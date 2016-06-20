require 'spec_helper'

describe System::JobPool do
  let(:job_pool) { System::JobPool.new() }

  context 'add_job' do
    it 'should create a job with dependency job' do
      job_pool.add_job('a', 'b')
      jobs_map = job_pool.instance_variable_get('@jobs_map')

      job = jobs_map['a']
      dependency_job = jobs_map['a'].dependency

      expect(jobs_map.count).to eq(2)
      expect(job).to be_a_kind_of(System::Job)
      expect(dependency_job).to be_a_kind_of(System::Job)
      expect(dependency_job.name).to eq('b')
      expect(job.name).to eq('a')
    end

    it 'should create a single job with no dependency job' do
      job_pool.add_job('a', nil)
      jobs_map = job_pool.instance_variable_get('@jobs_map')

      job = jobs_map['a']
      dependency_job = jobs_map['a'].dependency

      expect(jobs_map.count).to eq(1)
      expect(job).to be_a_kind_of(System::Job)
      expect(job.name).to eq('a')
      expect(dependency_job).to be_a_kind_of(System::NilJob)
    end
  end

  context 'enqueue_jobs' do
    it 'should enqueue job and its dependency such that its dependency is scheduled first' do
      job_pool.add_job('a', 'b')
      jobs_map = job_pool.instance_variable_get('@jobs_map')
      job = jobs_map['a']
      dep_job = jobs_map['a'].dependency

      job_scheduler = double(System::Scheduler)
      dep_scheduler = double(System::Scheduler)
      expect(job_scheduler).to receive(:schedule) { |&block| block.call }
      expect(dep_scheduler).to receive(:schedule).twice { |&block| block.call }

      expect(System::Scheduler).to receive(:new).with(job).and_return(job_scheduler)
      expect(System::Scheduler).to receive(:new).with(dep_job).and_return(dep_scheduler)

      job_pool.enqueue_jobs
      scheduled_jobs = job_pool.instance_variable_get('@scheduled_jobs')
      expect(scheduled_jobs).to include(job)
      expect(scheduled_jobs).to include(dep_job)

    end

    it 'should enqueue job without a dependency' do
      job_pool.add_job('a', nil)
      jobs_map = job_pool.instance_variable_get('@jobs_map')
      job = jobs_map['a']
      dep_job = jobs_map['a'].dependency
      expect(job.nil?).to eq(false)
      expect(dep_job.nil?).to eq(true)

      job_scheduler = double(System::Scheduler)
      expect(System::Scheduler).to receive(:new).with(job).and_return(job_scheduler)
      expect(job_scheduler).to receive(:schedule) { |&block| block.call }

      job_pool.enqueue_jobs
      scheduled_jobs = job_pool.instance_variable_get('@scheduled_jobs')
      expect(scheduled_jobs).to include(job)
    end
  end
end