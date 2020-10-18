class Lead < ApplicationRecord
  PURPOSE_OPTIONS = {
    add_me_to_newsletter: "newsletter",
    i_have_a_question: "faq",
    join_a_community: "lead",
    start_a_community: "start",
    becoming_a_coordinater: "coordinator",
    other: "other"
  }
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
  #validates :purpose, presence: true
  validates :body, presence: true

  def to_s
    'contact'
  end

  def self.position
    (ENV["NEW_LEAD_POSITION"] || 50).to_i
  end
  def purpose_text
    PURPOSE_OPTIONS[purpose] || purpose
  end
end
