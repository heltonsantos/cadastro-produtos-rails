class JobReport
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file_name, type: String
  field :status, type: String

  validates :file_name, presence: true
  validates :status, presence: true

end
