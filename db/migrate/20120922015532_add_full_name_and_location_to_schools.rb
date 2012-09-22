class AddFullNameAndLocationToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :full_name, :string
    add_column :schools, :location, :string
  end
end
