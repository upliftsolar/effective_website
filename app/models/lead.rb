class Lead < ApplicationRecord
  has_many_attached :documents

  effective_resource do
    locality :string

    timestamps
  end

  scope :deep, -> { all }

  validates :locality, presence: true

  def to_s
    'lead'
  end

  def self.position
    (ENV["NEW_LEAD_POSITION"] || 50).to_i
  end
end
