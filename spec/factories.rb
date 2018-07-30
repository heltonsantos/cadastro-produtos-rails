FactoryBot.define do
  
  factory :produto do
    sku "CA-123456789"
    nome "Camisa Polo"
    descricao "Lorem ipsum"
    quantidade 100
    preco 89
    ean 12345678 
  end
end

