# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  accepts_nested_attributes_for :links, reject_if: :all_blank

  def mark_as_best
    question.update(best_answer_id: id)
  end
end
