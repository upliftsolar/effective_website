class ServiceProvider < ApplicationRecord

  effective_resource do
    name          :string
    address       :string
    locality      :string
    email         :string
    phone         :string
    title         :string
    #verifications :text
    #flagged_text  :text

    timestamps
  end

  scope :deep, -> { all }
  scope :solar_installer, -> { where("title LIKE ?", "solar") }

  validates :name, presence: true
  validates :address, presence: true
  validates :locality, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :title, presence: true
  #validates :verifications, presence: true
  #validates :flagged_text, presence: true

  def to_s
    name || 'New service provider'
  end

  def self.position
    (ENV["SERVICE_PROVIDERS_POSITION"] || 92).to_i
  end

end
