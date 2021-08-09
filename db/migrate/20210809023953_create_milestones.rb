class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|

      t.timestamps
      t.string :title
      t.string :description
    end
  end
end
