class ChangeRoleToBeIntegerInUsers < ActiveRecord::Migration[7.1]
  def up
    remove_column :users, :role
    add_column :users, :role, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :role
    add_column :users, :role, :string, default: 'student', null: false
  end
end
