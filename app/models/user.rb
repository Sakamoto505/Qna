# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: :author_id, dependent: :destroy
  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :reward, dependent: :destroy
  has_many :votes, dependent: :destroy

  def is_owner?(resource)
    resource.id == id
  end

  def vote(resource, value)
    votes.create(votable: resource, value: value)
  end
end
