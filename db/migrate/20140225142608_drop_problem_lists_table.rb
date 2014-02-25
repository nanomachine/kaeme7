class DropProblemListsTable < ActiveRecord::Migration
  def up
  	remove_index :problems_lists, :problem_id
  	remove_index :problems_lists, :list_id
  	drop_table :problems_lists
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
