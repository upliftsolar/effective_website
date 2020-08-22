class Faq < ApplicationRecord

  effective_resource do
    locale           :string
    question         :string
    answer           :string
    archived         :boolean
    position         :integer
    activity_counter :integer
    featured         :boolean

    timestamps
  end

  scope :deep, -> { all }
  scope :answered, -> { where("answer is not null") }
  scope :unanswered, -> { where("answer is null") }
  scope :mine, Proc.new {|u| where(response_email: ((u && u.response_email)||"nonexistant")) }

  validates :question, presence: true

  #These are superflous: only protect against programmatic creation abuses:
  validates :locale, presence: true
  validates :position, presence: true
  validates :activity_counter, presence: true

  def to_s
    'faq'
  end

  def increment!
    #binding.pry 
  end
  def increment
    #binding.pry 
  end

end
