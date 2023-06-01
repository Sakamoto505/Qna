# frozen_string_literal: true

class Answer < ApplicationRecord
  include Votable
  include Commentable
  include PgSearch::Model
  pg_search_scope :search_everywhere, against: [:body]

  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  accepts_nested_attributes_for :links, reject_if: :all_blank

  def mark_as_best
    assign_reward if question.reward.present? # вызываем метод assign_reward, если награда присутствует
    question.update(best_answer_id: id)
  end

  def assign_reward
    question.reward.update(user: author)
  end
end
