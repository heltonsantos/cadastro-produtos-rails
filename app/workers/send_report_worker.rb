class SendReportWorker
  include Sidekiq::Worker
	include Sidekiq::Status::Worker
  sidekiq_options retry: false
  
  def perform(*args)

    csv = Produto.to_csv

    params = {:file => csv}
    uri = $EMAIL_SERVICE_API + "reports/upload_report"
  
    RequestHelper.request_post_form(uri, params)
    
  end
end
