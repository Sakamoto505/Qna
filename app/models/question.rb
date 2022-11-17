class Question < ApplicationRecord

  has_many :answers, dependent: :destroy

  validates :title,:body, presence: true

  validates :title,:body, presence: true
end
