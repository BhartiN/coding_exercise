require 'spec_helper'

describe System::Job do
	  context 'create' do
	  	it 'should create a job with name and dependency' do
	  		job = System::Job.new('abc', 'def')
	  		expect(job.name).to eq('abc')
	  		expect(job.dependency).to eq('def')
	  	end

	  	it 'should create a job with name and default dependency' do
	  		job = System::Job.new('abc')
	  		expect(job.name).to eq('abc')
	  		expect(job.dependency).to be_nil
	  	end

	  end
end