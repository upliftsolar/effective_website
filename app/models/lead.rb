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

end
