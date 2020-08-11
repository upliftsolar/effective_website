class Community < ApplicationRecord
  acts_as_addressable :billing, :shipping  # effective_addresses
  acts_as_archived                         # effective_resources
  log_changes                              # effective_logging

  has_many :mates, -> { order(:roles_mask) }, dependent: :destroy, inverse_of: :community, counter_cache: :mates_count
  has_many :users, through: :mates
  accepts_nested_attributes_for :mates
  has_one_attached :flyer

  effective_resource do
    name            :string
    phone           :string
    email           :string

    archived        :boolean, permitted: false

    mates_count     :integer
    timestamps
  end

  scope :sorted, -> { order(:name) }
  scope :deep, -> { includes(:addresses, :users) }
  scope :datatables_filter, -> { sorted.select(:name, :id) }

  scope :for_user, lambda { |user| Community.unscoped.where(id: user&.community_ids) }

  validates :name, presence: true, uniqueness: true

  def to_s
    name.presence || 'New Community'
  end
end
