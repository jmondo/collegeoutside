class MakeUserPartOfSchool < ActiveRecord::Migration
  class User < ActiveRecord::Base
    has_many :articles
  end

  class Article < ActiveRecord::Base
    belongs_to :user,
      counter_cache: true
  end

  def change
    add_column :users, :school_id, :integer
    add_column :users, :position, :string
    add_column :users, :photo, :string
    add_index :users, :school_id

    add_column :users, :articles_count, :integer

    User.reset_column_information
    User.find_each do |u|
      User.reset_counters(u.id, :articles)
    end
  end
end
