class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    # column order optimized based on: https://gist.github.com/hopsoft/480fb99187cee3de51d521ee1bd264ff
    create_table :projects do |t|
      t.timestamps
      t.datetime :sychronized_at
      t.integer :forks_count, null: false, default: 0
      t.integer :open_issues_count, null: false, default: 0
      t.integer :stars_count, null: false, default: 0
      t.integer :subscribers_count, null: false, default: 0
      t.boolean :archived, null: false, default: false
      t.boolean :disabled, null: false, default: false
      t.text :name, null: false
      t.text :description
      t.text :url
      t.text :repo_url, null: false
      t.text :license_name
      t.text :license_url
      t.text :tags, array: true, default: [], null: false

      t.index :name
      t.index :tags, using: :gin
    end
  end
end
