module System
  module SchedulingService
    def initialize
      @schedulers = {}
      @scheduled_jobs = []
    end

    def enqueue(job)
      return if job.nil?
      scheduler_for(job).schedule do
        enqueue(job.dependency)
        @scheduled_jobs << job.ready
      end
    end

    private
    def scheduler_for(job)
      @schedulers[job.name] ||= Scheduler.new(job)
    end

    def print_executed_jobs
      puts 'Order of scheduling is: '
      @scheduled_jobs.each do |job|
        print "#{job.name} "
      end
    end

  end
end

