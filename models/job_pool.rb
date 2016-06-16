module System	
	class JobPool

    attr_accessor :jobs_map

		def initialize()
			@jobs_map = {}
		end

		def add_job(name,dependency)
			job = get_job_for(name)
			dependency_job = get_job_for(dependency)			
			job.depends_on(dependency_job)
		end

		private

		def get_job_for(name) 
			return nil if name.nil?			
			@jobs_map[name] ||= Job.new(name)
		end

	end
end
