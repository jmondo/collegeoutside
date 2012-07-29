class CreateArticlesSeasonsTable < ActiveRecord::Migration
  def change
    create_table :articles_seasons, id: false do |t|
      t.integer :article_id
      t.integer :season_id
    end
    add_index :articles_seasons, :article_id
    add_index :articles_seasons, :season_id
  end
end
