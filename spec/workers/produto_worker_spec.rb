require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ProdutoWorker, type: :worker do

  context 'when the worker is created' do
    it "creates the worker" do
      
      file_name = "produtos-report-#{Time.now.to_i}.csv"
      job_report = JobReport.create({:file_name => file_name, :status => "enqueued"})
    

      ProdutoWorker.perform_async(job_report._id.to_s)
      expect(ProdutoWorker.jobs.size).to eq(1)

      ProdutoWorker.drain
      expect(ProdutoWorker.jobs.size).to eq(0)    
    end

    it "valides if the report was created" do
      file_path = Dir.glob("db/reports/#{Rails.env}/*.csv")[0]
      data = File.read(file_path)
      
      produtos = []
      csv = CSV.parse(data, :headers => true)
      csv.each do |row| 
        produtos << Produto.new(row.to_hash)
      end

      produtosDB = Produto.all
     
      expect(data).not_to be_nil
      expect(produtos.size).to eq(produtosDB.size)
      expect(produtos[0].sku).to eq(produtosDB[0].sku)
      expect(produtos[0].nome).to eq(produtosDB[0].nome) 
      expect(produtos[0].descricao).to eq(produtosDB[0].descricao) 
      expect(produtos[0].quantidade).to eq(produtosDB[0].quantidade) 
      expect(produtos[0].preco).to eq(produtosDB[0].preco)
      expect(produtos[0].ean).to eq(produtosDB[0].ean)

    end
    
  end  

end
