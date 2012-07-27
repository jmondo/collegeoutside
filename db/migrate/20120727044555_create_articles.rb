class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id, null: false
      t.text :body, null: false
      t.string :title, null: false
      t.integer :region_id
      t.integer :state_id
      t.integer :school_id, null: false
      t.boolean :featured, null: false, default: false
      t.boolean :sponsored, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end
    add_index :articles, :published_at
  end
end
