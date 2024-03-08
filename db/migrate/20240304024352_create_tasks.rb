class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :due_date
      t.text :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
