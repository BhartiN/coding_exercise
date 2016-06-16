require 'spec_helper'

describe System::JobPool do
	let(:job_pool) { System::JobPool.new() }
  
	  context 'add_job' do
	  	it 'should create a job with dependency job' do
	  		job_pool.add_job('a', 'b')
	  		
	  		job = job_pool.jobs_map['a']
	  		dependency_job = job_pool.jobs_map['a'].dependency

				expect(job_pool.jobs_map.count).to eq(2)
	  		expect(job).to be_a_kind_of(System::Job)
	  		expect(dependency_job).to be_a_kind_of(System::Job)
	  		expect(dependency_job.name).to eq('b')
	  		expect(job.name).to eq('a')
	  	end

	  	it 'should create a single job with no dependency job' do
	  		job_pool.add_job('a', nil)
	  		
	  		job = job_pool.jobs_map['a']
	  		dependency_job = job_pool.jobs_map['a'].dependency

				expect(job_pool.jobs_map.count).to eq(1)
	  		expect(job).to be_a_kind_of(System::Job)
	  		expect(job.name).to eq('a')
	  		expect(dependency_job).to be_nil
	  	end
	  end
end