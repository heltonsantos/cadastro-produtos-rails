require 'rails_helper'

RSpec.describe Produto, :type => :model do
	subject { 
		described_class.new(
                        sku: "CA-123456789", 
                        nome: "Camisa Polo",
			                  descricao: "Lorem ipsum", 
                        quantidade: 100, 
                        preco: 89.90, 
                        ean: 12345678
                        ) 
	}

  context "When the product attributes is valid" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

 context "When the product attributes is not valid" do
    it "is not valid without a SKU" do
      subject.sku = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with special characters" do
      subject.sku = "CA.123456789" 
      expect(subject).to_not be_valid
    end  

    it "is not valid without a name" do
      subject.nome = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a description" do
      subject.descricao = nil
      expect(subject).to_not be_valid
    end 
    
    it "is not valid without a amount" do
      subject.quantidade = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a price" do
      subject.preco = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when the prince is less than 1" do
      subject.preco = 0
      expect(subject).to_not be_valid
    end

    it "is not valid without a EAN" do
      subject.ean = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when the size is smaller than 8" do
      subject.ean = 1234567
      expect(subject).to_not be_valid
    end

    it "is not valid when the size is larger than 13" do
      subject.ean = 12345678910123
      expect(subject).to_not be_valid
    end

  end  	

end