class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :date
      t.integer :no_of_seats
      t.references :bus, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
