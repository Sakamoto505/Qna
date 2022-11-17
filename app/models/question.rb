class Question < ApplicationRecord
<<<<<<< HEAD

  has_many :answers, dependent: :destroy

  validates :title,:body, presence: true
=======
>>>>>>> main
end
