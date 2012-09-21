require 'friendly_id'

class AddSlugsToModels < ActiveRecord::Migration
  class School < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
  end

  class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged
  end

  class Activity < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
  end

  class User < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
  end

  def up
    [:schools, :articles, :activities, :users].each do |table_sym|
      add_column table_sym, :slug, :string
      add_index table_sym, :slug, unique: true
    end

    [School, Article, Activity, User].each do |model|
      model.reset_column_information
      model.find_each(&:save)
    end
  end

  def down
    remove_column :schools, :slug
    remove_column :articles, :slug
    remove_column :activities, :slug
    remove_column :users, :slug
  end
end
