require 'spec_helper'

describe System::Main do
  context 'schedule jobs' do
    let(:job_pool) { System::JobPool.new() }

    it 'should enqueue a single job' do
      job_pool.add_job('a', nil)
      expect { job_pool.enqueue_jobs }.to output("Order of scheduling is: \na ").to_stdout
    end

    it 'should enqueue a single job with dependency' do
      job_pool.add_job('a', 'b')
      expect { job_pool.enqueue_jobs }.to output("Order of scheduling is: \nb a ").to_stdout
    end

    it 'should enqueue all jobs with no dependencies' do
      job_pool.add_job('a', nil)
      job_pool.add_job('b', nil)
      job_pool.add_job('c', nil)
      expect{job_pool.enqueue_jobs}.to output("Order of scheduling is: \na b c ").to_stdout
    end

    it 'should enqueue all jobs containing single level dependency' do
      job_pool.add_job('a', nil)
      job_pool.add_job('b', 'c')
      job_pool.add_job('c', nil)
      expect{job_pool.enqueue_jobs}.to output("Order of scheduling is: \na c b ").to_stdout
    end

    it 'should enqueue all jobs having multi level dependency' do
      job_pool.add_job('a', nil)
      job_pool.add_job('b', 'c')
      job_pool.add_job('c', 'f')
      job_pool.add_job('d', 'a')
      job_pool.add_job('e', 'b')
      job_pool.add_job('f', nil)
      expect{job_pool.enqueue_jobs}.to output("Order of scheduling is: \na f c b d e ").to_stdout
    end

    context 'cyclic dependency' do
      it 'should report error when a job depends on itself' do
        job_pool.add_job('a', nil)
        job_pool.add_job('b', nil)
        job_pool.add_job('c', 'c')
        expect { job_pool.enqueue_jobs }.to output('Cyclic dependency detected in jobs input').to_stdout
      end
    end

    it 'should report when jobs depends on each other in a cyclic manner' do
        job_pool.add_job('a', nil)
        job_pool.add_job('b', 'c')
        job_pool.add_job('c', 'f')
        job_pool.add_job('d', 'a')
        job_pool.add_job('e', nil)
        job_pool.add_job('f', 'b')

        expect { job_pool.enqueue_jobs }.to output('Cyclic dependency detected in jobs input').to_stdout
      end
    end
end
