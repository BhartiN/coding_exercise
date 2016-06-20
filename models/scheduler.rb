module System
  class Scheduler
    module States
      UNSCHEDULED = 'unscheduled'
      SCHEDULING = 'scheduling'
      SCHEDULED = 'scheduled'
    end

    def initialize(job)
      @status = States::UNSCHEDULED
      @job = job
    end

    def schedule(&block)
      return if @status == States::SCHEDULED
      raise RuntimeError.new if @status == States::SCHEDULING

      @status = States::SCHEDULING
      block.call
      @status = States::SCHEDULED
    end

  end
end

