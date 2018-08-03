require 'faker'

FactoryBot.define do
  
  factory :produto do
    sku Faker::Commerce.promotion_code[1..15]
    nome Faker::Commerce.product_name[3..50]
    descricao Faker::Hobbit.quote[5..100]
    quantidade Faker::Number.number(10)
    preco Faker::Commerce.price
    ean Faker::Number.number(10)
  end
end

