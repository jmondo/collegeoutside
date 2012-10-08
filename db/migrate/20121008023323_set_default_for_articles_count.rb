class SetDefaultForArticlesCount < ActiveRecord::Migration
  def up
    User.find_each do |u|
      User.reset_counters(u.id, :articles)
    end
    change_column_default :users, :articles_count, 0
    change_column_null :users, :articles_count, false
  end

  def down
    change_column_null :users, :articles_count, true
    change_column_default :users, :articles_count, nil
  end
end
