class ProdutoWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false
  
  def perform(job_report_id)
 		
 		job_report = JobReport.find(job_report_id)	
    
    Produto.write_csv(job_report.file_name)

    job_report.update({:status => "DONE"})

    SendReportWorker.perform_async(job_report_id)
    
  end
end
