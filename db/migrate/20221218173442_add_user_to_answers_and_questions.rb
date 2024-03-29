# frozen_string_literal: true

class AddUserToAnswersAndQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :author, foreign_key: { to_table: :users }
    add_reference :answers, :author, foreign_key: { to_table: :users }
  end
end
