require 'rails_helper'

RSpec.describe JobReport, type: :model do
  subject { 
		described_class.new(
                        file_name: "produtos-report.csv", 
                        status: "DONE"
                        ) 
	}

  context "When the job report attributes is valid" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

 context "When the job report attributes is not valid" do
    it "is not valid without a name" do
      subject.file_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without status" do
      subject.status = nil 
      expect(subject).to_not be_valid
    end 
  end   

end
