class ProdutoWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false
  
  def perform(file_name)
    
    Produto.write_csv(file_name)
  end
end
