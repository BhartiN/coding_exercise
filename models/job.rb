module System
	class Job
		attr_reader :name, :dependency

		def initialize(name, dependency=nil)
			@name = name
			@dependency = dependency
		end

		def depends_on(value)
			@dependency = value
		end
	end
end
