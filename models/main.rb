module System	
	class Main
		
		def initialize
			@job_pool = JobPool.new

			puts "Enter dependencies. Enter 'ex(it)' to quit entering when done"
			loop do 
				input = gets.chomp
				break if input.downcase.start_with?('ex')
				name,dependency = input.split('=>').map(&:strip)

				@job_pool.add_job(name,dependency) unless name.empty?
      end
      @job_pool.enqueue_jobs
      puts ''
    end

	end
end
