class CreateWantedItems < ActiveRecord::Migration
  def change
    create_table :wanted_items do |t|
      t.integer :school_id
      t.text :description

      t.timestamps
    end
    add_index :wanted_items, :school_id
  end
end
