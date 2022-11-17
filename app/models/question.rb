class Question < ApplicationRecord

  validates :title,:body, presence: true


  has_many :answers, dependent: :destroy

  validates :title,:body, presence: true
end
