class ProdutoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(*args)
    
    produtos = Produto.all
    produtos.write_csv
  end
end
