class Produto
	include Mongoid::Document
	include Mongoid::Timestamps
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  index_name ['produtos', Rails.env].join('_')

  
	field :sku, type: String
	field :nome, type: String
	field :descricao, type: String
	field :quantidade, type: Integer
	field :preco, type: Float
	field :ean, type: Integer

	settings do
    mappings dynamic: false do
      indexes :sku, type: :String		
      indexes :nome, type: :String
      indexes :descricao, type: :String, analyzer: :portuguese
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << %w(sku nome descricao quantidade preco ean)

      all.each do |produto|
        csv << [
                produto.sku, 
                produto.nome, 
                produto.descricao,
                produto.quantidade,
                produto.preco,
                produto.ean]
      end
    end
  end

  def self.write_csv(file_name)
    csv_string = CSV.generate do |csv|
      csv << %w(sku nome descricao quantidade preco ean)

      all.each do |produto|
        csv << [
                produto.sku, 
                produto.nome, 
                produto.descricao,
                produto.quantidade,
                produto.preco,
                produto.ean
              ]
      end
    end
    
    File.open("db/reports/#{Rails.env}/#{file_name}", "w") {|f| f.write(csv_string) }

  end

	def as_indexed_json(options={})
   		self.as_json({
   									only: [
   												:id, 
   												:sku, 
   												:nome, 
   												:descricao, 
   												:quantidade, 
   												:preco, 
   												:ean
   												]
   									})
 	end

	validates :sku, presence: true,
									length: { maximum: 15 },
									format: { with: /\A[a-zA-Z0-9\-]*\z/, message: "alpha-numeric and characters only" }

	validates :nome, presence: true,
	            		 length: { minimum: 3, maximum: 50 }

	validates :descricao, presence: true,
												length: { minimum: 5,  maximum: 100}

	validates :quantidade, presence: true, 
												numericality: true

	validates :preco, presence: true, 
										numericality: { greater_than: 0, message: "must be greater than 0" }

	validates :ean, presence: true, 
									numericality: true,
									length: { minimum: 8,  maximum: 13}				           	

end
