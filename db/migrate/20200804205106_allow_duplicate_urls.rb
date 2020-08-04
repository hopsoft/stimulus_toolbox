# frozen_string_literal: true

class AllowDuplicateUrls < ActiveRecord::Migration[6.0]
  def change
    remove_index :projects, "lower(btrim(github_name))"
    remove_index :projects, "lower(btrim(npm_name))"
    remove_index :projects, :github_url
    remove_index :projects, :npm_url
  end

  def down
    add_index :projects, "lower(btrim(github_name))", unique: true, where: "github_name != null"
    add_index :projects, "lower(btrim(npm_name))", unique: true, where: "npm_name != null"
    add_index :projects, :github_url, unique: true, where: "github_url != null"
    add_index :projects, :npm_url, unique: true, where: "npm_url != null"
  end
end
