class CreateScavengers < ActiveRecord::Migration
  def change
    create_table :scavengers do |t|
    	t.integer :user_id
    	t.datetime :date_time
    	t.string :hunt_name
    	t.string :location
    	t.string :description
      t.timestamps null: false
    end
  end
end
