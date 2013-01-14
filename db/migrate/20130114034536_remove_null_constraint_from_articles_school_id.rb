class RemoveNullConstraintFromArticlesSchoolId < ActiveRecord::Migration
  def up
    change_column_null :articles, :school_id, true
  end

  def down
    change_column_null :articles, :school_id, false
  end
end
