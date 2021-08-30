class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|

      t.timestamps
      t.string :title
      t.string :description
      t.datetime :deadline
      t.integer :status, default: 1
      t.integer :user_id
    end
  end
end
