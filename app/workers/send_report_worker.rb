class SendReportWorker
  include Sidekiq::Worker
	include Sidekiq::Status::Worker
  sidekiq_options retry: false
  
  def perform(job_report_id)
 		
 		job_report = JobReport.find(job_report_id)	
    
    Produto.write_csv(job_report.file_name)

    job_report.update({:status => "DONE"})

    data = File.read("db/reports/#{Rails.env}/#{job_report.file_name}")
    csv = CSV.parse(data, :headers => true)
    params = {:file => csv}
    uri = $EMAIL_SERVICE_API + "reports/upload_report"
  
    RequestHelper.request_post_form(uri, params)

    job_report.update({:status => "SENT"})
    
  end
end
