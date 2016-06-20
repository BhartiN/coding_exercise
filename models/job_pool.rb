module System
	class JobPool
    include System::SchedulingService

    # attr_reader :jobs_map

		def initialize()
			@jobs_map = {}
      super
		end

		def add_job(name,dependency)
			dependency_job = get_job_for(dependency)
      job = get_job_for(name)
			job.depends_on(dependency_job)
		end

    def enqueue_jobs
      begin
        @jobs_map.values.each do |job|
          enqueue(job)
        end
        get_executed_jobs
      rescue Exception => e
        print 'Cyclic dependency detected in jobs input' and exit(true)
        exit(false)
      end
    end

    private

		def get_job_for(name)
      return NilJob.new if name.nil?
			@jobs_map[name] ||= Job.new(name)
    end

	end
end
