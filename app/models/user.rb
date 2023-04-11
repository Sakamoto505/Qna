# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]


  has_many :questions, class_name: 'Question', foreign_key: :author_id, dependent: :destroy
  has_many :answers, class_name: 'Answer', foreign_key: :author_id, dependent: :destroy
  has_many :reward, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def is_owner?(resource)
    resource.author_id == id
  end

  def vote(resource, value)
    votes.create(votable: resource, value: value)
  end
end
