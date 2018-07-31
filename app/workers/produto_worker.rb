class ProdutoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(*args)
    
    Produto.write_csv
  end
end
