class AddGeolocationToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :geolocation, :string
  end
end
