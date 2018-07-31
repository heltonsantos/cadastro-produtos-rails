class ProdutosController < ApplicationController
  before_filter :find_product, except: [:index, :new, :create, :show, :report]

  def index
    query = params[:search_produtos].presence && params[:search_produtos][:query]

    if query
      @produtos = Produto.search(query)
    else
      @produtos = Produto.all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @produtos.to_csv, filename: "produtos-report-#{Time.now.to_i}.csv" }
    end
  end 

  def show
    produto = $redis.get(params[:id])

    if produto.nil?
      @produto = Produto.find(params[:id])
      $redis.set(@produto.id, @produto.to_json)
    else
      @produto = Produto.new.from_json(produto)
    end
  end

  def new
    @produto = Produto.new
  end

  def edit
  end

  def create
    @produto = Produto.new(produto_params)

    if @produto.save
      $logger.info '{"message":"Produto ' + @produto.id + ' cadastrado.", "event_group":"create"}'
      redirect_to @produto
    else
      render 'new'
    end   
  end

  def update

    if @produto.update(produto_params)
      $redis.set(@produto.id, @produto.to_json)
      $logger.info '{"message":"Produto ' + @produto.id + ' atualizado.", "event_group":"update"}'

      redirect_to @produto
    else
      render 'edit'
    end
  end

  def destroy
    @produto.destroy

    $redis.del(@produto.id)
    $logger.info '{"message":"Produto ' + @produto.id + ' deletado.", "event_group":"delete"}'

    redirect_to produtos_path
  end

  def report
    ProdutoWorker.perform_async

    redirect_to produtos_path
  end 
  

  private

  def find_product
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit(:sku, :nome, :descricao, :quantidade, :preco, :ean)
  end
end
