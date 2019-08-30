class AddSlugToBus < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :slug, :string
    add_index :buses, :slug, unique: true
  end
end
