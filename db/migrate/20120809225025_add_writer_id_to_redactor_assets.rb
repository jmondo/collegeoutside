class AddWriterIdToRedactorAssets < ActiveRecord::Migration
  def change
    add_column :redactor_assets, :writer_id, :integer
    add_index :redactor_assets, :writer_id
  end
end
