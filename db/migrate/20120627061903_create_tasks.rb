class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :due_date
      t.boolean :important, :default => 0
      t.boolean :completed, :default => 0
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
