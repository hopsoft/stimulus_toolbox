# frozen_string_literal: true

class CreateFullTextSearches < ActiveRecord::Migration[6.0]
  def change
    # column order optimized based on: https://gist.github.com/hopsoft/480fb99187cee3de51d521ee1bd264ff
    create_table :full_text_searches do |t|
      t.timestamps
      t.integer :record_id, null: false
      t.string :record_type, null: false
      t.tsvector :value

      t.index [:record_type, :record_id], unique: true
      t.index :value, using: :gin
    end
  end
end
