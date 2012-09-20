class AddCoverPhotoToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cover_photo, :string
    add_column :articles, :cover_photo_caption, :string
  end
end
