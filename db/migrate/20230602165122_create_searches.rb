class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.references :searchable, polymorphic: true, null: false
      t.string :query

      t.timestamps
    end
    add_index :searches, :query
  end
end
