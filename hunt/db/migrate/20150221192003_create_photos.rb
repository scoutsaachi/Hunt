class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.integer :user_id
    	t.integer :team_id
    	t.integer :task_id
    	t.datetime :date_time
    	t.string :file_name
      t.timestamps null: false
    end
  end
end
