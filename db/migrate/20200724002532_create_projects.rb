class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    # column order optimized based on: https://gist.github.com/hopsoft/480fb99187cee3de51d521ee1bd264ff
    create_table :projects do |t|
      t.timestamps
      t.datetime :github_sychronized_at
      t.datetime :npm_sychronized_at
      t.text :human_name, null: false
      t.text :github_name
      t.text :npm_name
      t.text :description
      t.text :url
      t.text :github_url
      t.text :npm_url
      t.text :license_name
      t.text :license_url
      t.text :tags, array: true, default: [], null: false
      t.jsonb :github_data, null: false, default: "{}"
      t.jsonb :npm_data, null: false, default: "{}"

      t.index :human_name, unique: true
      t.index :github_name, unique: true
      t.index :npm_name, unique: true
      t.index :url, unique: true
      t.index :github_url, unique: true
      t.index :npm_url, unique: true
      t.index :tags, using: :gin
    end
  end
end
