class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|

      t.timestamps
      t.string :title
      t.string :description
      t.integer :goal_id
      t.integer :status, default: 0
    end
  end
end
