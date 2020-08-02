class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    # column order optimized based on: https://gist.github.com/hopsoft/480fb99187cee3de51d521ee1bd264ff
    create_table :projects do |t|
      t.boolean :approved, default: false, null: false
      t.timestamps
      t.datetime :github_sychronized_at
      t.datetime :npm_sychronized_at
      t.text :name, null: false
      t.text :github_name
      t.text :npm_name
      t.text :description, null: false
      t.text :url, null: false
      t.text :github_url
      t.text :npm_url
      t.text :tags, array: true, default: [], null: false
      t.jsonb :github_data, null: false, default: {}
      t.jsonb :npm_data, null: false, default: {}

      t.index :approved
      t.index "lower(btrim(name))", unique: true
      t.index "lower(btrim(github_name))", unique: true, where: "github_name != null"
      t.index "lower(btrim(npm_name))", unique: true, where: "npm_name != null"
      t.index :url, unique: true
      t.index :github_url, unique: true, where: "github_url != null"
      t.index :npm_url, unique: true, where: "npm_url != null"
      t.index :tags, using: :gin
    end
  end
end
