class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|

      t.timestamps
      t.string :title
      t.string :description
    end
  end
end
