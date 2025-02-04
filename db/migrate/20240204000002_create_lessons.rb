class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :assigned_to, null: false, foreign_key: { to_table: :users }
      t.string :youtube_url
      t.timestamps
    end

    add_index :lessons, [:teacher_id, :created_at]
    add_index :lessons, [:assigned_to_id, :created_at]
  end
end 