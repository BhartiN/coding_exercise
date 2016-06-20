require 'spec_helper'

describe System::NilJob do
  let(:nil_job) { System::NilJob.new }

  context 'create' do
    it 'should create a nil job with name and dependency as nil' do
      expect(nil_job.name).to eq(nil)
      expect(nil_job.dependency).to be_nil
      expect(nil_job.nil?).to be(true)
    end
  end

end