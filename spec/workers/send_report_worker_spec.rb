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
      
      SendReportWorker.perform_async
      expect(SendReportWorker.jobs.size).to eq(1)

      SendReportWorker.drain
      expect(SendReportWorker.jobs.size).to eq(0)    
    end
  end  


end
