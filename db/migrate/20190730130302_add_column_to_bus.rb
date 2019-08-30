class AddColumnToBus < ActiveRecord::Migration[5.2]
  def change
    add_reference :buses, :owner, foreign_key: true
  end
end
