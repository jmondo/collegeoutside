class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
