module System
	class Job
		attr_reader :name, :dependency

		def initialize(name)
			@name = name
			@dependency = NilJob.new
		end

		def depends_on(job)
			@dependency = job
    end

    def ready
      #do something
      return self
    end

  end
end