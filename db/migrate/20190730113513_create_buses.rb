class CreateBuses < ActiveRecord::Migration[5.2]


  def change
    create_table :buses do |t|
      t.string :name
      t.string :registration_no
      t.string :source
      t.string :destination
      t.integer :total_seats
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
