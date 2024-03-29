# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.boolean :gist
      t.belongs_to :linkable, polymorphic: true

      t.timestamps
    end
  end
end
