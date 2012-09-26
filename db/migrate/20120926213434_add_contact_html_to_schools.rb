class AddContactHtmlToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :contact_html, :text
  end
end
