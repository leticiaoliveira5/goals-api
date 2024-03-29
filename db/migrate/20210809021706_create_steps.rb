class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|

      t.timestamps
      t.string :title
      t.string :description
      t.integer :milestone_id
      t.integer :status, default: 0
    end
  end
end
