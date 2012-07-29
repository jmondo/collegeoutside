class CreateActivitiesArticles < ActiveRecord::Migration
  def change
    create_table :activities_articles, id: false do |t|
      t.integer :article_id
      t.integer :activity_id
    end
    add_index :activities_articles, :article_id
    add_index :activities_articles, :activity_id
  end
end
