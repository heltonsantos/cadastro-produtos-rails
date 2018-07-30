require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ProdutoWorker, type: :worker do

  context 'when the worker is created' do
      it "creates workers" do
        
        ProdutoWorker.perform_async
        ProdutoWorker.perform_async
        expect(ProdutoWorker.jobs.size).to eq(2)

        ProdutoWorker.drain
        expect(ProdutoWorker.jobs.size).to eq(0)    
      end
    end  

end
