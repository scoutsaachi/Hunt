class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.string :task_name
    	t.integer :scavenger_id
    	# point value
    	t.integer :value 
      t.timestamps null: false
    end
  end
end
