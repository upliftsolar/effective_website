class Lead < ApplicationRecord
  PURPOSE_OPTIONS = {"I have a question not answered on the FAQs page" => "faq","I would like to
    join a community and become a customer"=>"lead","I would like to start a Community Partner
    organization or association"=>"start","I’m interested in becoming a Community Coordinator"=>"coordinator","Other"=>"other"}
  has_many_attached :documents

  effective_resource do
    full_name :string
    contact_info :string
    purpose :string
    body :text
    locality :string
    timestamps
  end

  scope :deep, -> { all }

  validates :full_name, presence: true
  validates :contact_info, presence: true
  validates :purpose, presence: true
  validates :body, presence: true

  def to_s
    'contact'
  end

  def self.position
    (ENV["NEW_LEAD_POSITION"] || 50).to_i
  end
end
