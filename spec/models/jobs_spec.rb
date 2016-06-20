require 'spec_helper'

describe System::Job do
  let(:job) { System::Job.new('abc') }

  context 'create' do
    it 'should create a job with name and nil dependency' do
      expect(job.name).to eq('abc')
      expect(job.dependency).to be_nil
    end
  end

  context 'set dependency' do
    it 'should set job dependency' do
      expect(job.dependency).to be_nil
      job.depends_on('b')
      expect(job.dependency).to eq('b')
    end
  end

  context 'execute' do
    it 'should execute' do
      expect(job.ready).to eq(job)
    end
  end
end