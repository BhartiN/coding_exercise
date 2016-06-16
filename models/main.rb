module System	
	class Main
		
		def initialize
			@job_pool = JobPool.new

			puts "Enter dependencies. Enter 'Exit' to quit entering when done"
			loop do 
				input = gets.chomp
				break if input.downcase=='exit'
				name,dependency = input.split('=>').map(&:strip)

				@job_pool.add_job(name,dependency) unless name.empty?
			end
		end
		
	end
end
