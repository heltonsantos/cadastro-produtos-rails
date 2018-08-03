require 'rails_helper'
require 'fakeweb'
require 'fakeweb'

Sidekiq::Testing.fake!
FakeWeb.register_uri(:post, "http://teste.com/api/v1/reports/upload_report", 
	:body => "", :parameters => {:file => "csv"}, 
	:status => ["200", "OK"])

RSpec.describe SendReportWorker, type: :worker do

	context 'when the worker is created' do
    it "creates the worker" do
    	file_name = "produtos-report-test.csv"
    	job_report = JobReport.create({:file_name => file_name, :status => "enqueued"})

    	FileUtils.cp("spec/fixtures/#{file_name}", "db/reports/#{Rails.env}/#{file_name}")
      
      SendReportWorker.perform_async(job_report._id.to_s)
      expect(SendReportWorker.jobs.size).to eq(1)

      SendReportWorker.drain
      expect(SendReportWorker.jobs.size).to eq(0)    
    end
  end  


end
