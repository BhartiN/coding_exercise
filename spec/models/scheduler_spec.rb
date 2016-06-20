require 'spec_helper'

describe System::Scheduler do
  let(:job) { System::Job.new('a') }
  let(:scheduler) { System::Scheduler.new(job) }

  context 'schedule' do
    it 'should schedule a job and set its state to scheduled after executing the passed block' do
      a = 'testStr'
      expect(scheduler.instance_variable_get('@status')).to eq(System::Scheduler::States::UNSCHEDULED)

      scheduler.schedule {a.downcase!}
      expect(scheduler.instance_variable_get('@status')).to eq(System::Scheduler::States::SCHEDULED)
      expect(a).to eq('teststr')
    end

    it 'should raise exception in case of cyclic dependency and not execute the block' do
      a = double()
      expect(scheduler.instance_variable_get('@status')).to eq(System::Scheduler::States::UNSCHEDULED)
      scheduler.instance_variable_set('@status', System::Scheduler::States::SCHEDULING)

      expect(a).not_to receive(:random_method_call)
      expect {scheduler.schedule {a.random_method_call}}.to raise_error(RuntimeError)
      expect(scheduler.instance_variable_get('@status')).to eq(System::Scheduler::States::SCHEDULING)
    end

  end

end