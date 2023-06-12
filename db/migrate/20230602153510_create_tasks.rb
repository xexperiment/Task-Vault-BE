class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, limit: 25
      t.string :description, null: false
      t.integer :status, default: 0, null: false
      t.integer :priority, default: 0, null: false
      t.datetime :deadline, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
