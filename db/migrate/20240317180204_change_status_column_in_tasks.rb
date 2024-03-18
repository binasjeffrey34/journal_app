class ChangeStatusColumnInTasks < ActiveRecord::Migration[7.1]
  def up
    change_column :tasks, :status, 'boolean USING CASE WHEN status = \'Completed\' THEN TRUE ELSE FALSE END'
  end

  def down
    change_column :tasks, :status, :text
  end
end
