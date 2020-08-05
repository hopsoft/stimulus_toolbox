class ProjectFixSyncTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :github_sychronized_at, :github_synchronized_at
    rename_column :projects, :npm_sychronized_at, :npm_synchronized_at
  end
end
