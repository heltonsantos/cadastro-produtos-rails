require "rails_helper"

describe ProdutosController do
  render_views

  describe "GET index" do
    context 'when the index is accessed' do  
    	it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "assigns @produtos" do
        produto = create(:produto)
        get :index
        expect(assigns(:produtos)).to eq([produto])
      end

     	it "says 'Produtos'" do
        get :index
        expect(response.body).to match /Produtos/m
      end
    end
  end

  describe "POST create" do
    context 'when the product is created' do
      it "renders to show template with product id" do
        
        params = { 
                  produto: { 
                            sku: "CA-123456710", 
                            nome: "Camisa Polo", 
                            descricao: "Lorem ipsum", 
                            quantidade: 100, 
                            preco: 89.90, 
                            ean: 12345678 
                            } 
                  }

        post :create, params

        produto = Produto.find_by sku: 'CA-123456710'

        expect(response).to redirect_to(produtos_path+"/"+produto.id)
        expect(response.status).to eq(302)
      end
    end  
  end

  describe "GET show" do
    context 'when the product is found' do
      it "renders to show template with the product" do

        produto = Produto.find_by sku: 'CA-123456710'

        params = { id: produto.id }
        post :show, params

        expect(response.body).to match /CA-123456710/m
        expect(response).to render_template("show")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST update" do
    context 'when the product is updated' do  
      it "updates a product" do
        produto = Produto.find_by sku: 'CA-123456710'

        params = { 
                  id: produto.id, 
                  produto: { 
                    sku: "CA-123456710", 
                    nome: "Camisa Polo", 
                    descricao: "Lorem ipsum",
                    quantidade: 150,
                    preco: 94.90,
                    ean: 12345678
                  } 
                }
        post :update, params

        produtoAtt = Produto.find_by sku: 'CA-123456710'

        expect(produtoAtt.quantidade).to eq(150)
        expect(produtoAtt.preco).to eq(94.90)

        expect(response).to redirect_to(produtos_path+"/"+produtoAtt.id)
        expect(response.status).to eq(302) 
      end
    end  
  end

  describe "DELETE destroy" do
    context 'when the product is destroyed' do  
      it "deletes a product" do
        produto = Produto.find_by sku: 'CA-123456710'

        params = { id: produto.id }
        post :destroy, params

        expect { Produto.find_by id: produto.id }.to raise_error(Mongoid::Errors::DocumentNotFound)

        expect(response).to redirect_to(produtos_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET report" do
    context 'when the products are reported' do  
      it "creates a report" do
        get :report

        expect(response).to redirect_to(produtos_path)
        expect(response.status).to eq(302)


      end
    end  
  end

end