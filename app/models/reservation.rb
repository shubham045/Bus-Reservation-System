class Reservation < ApplicationRecord


  validates :date, presence: true

  belongs_to :bus
  belongs_to :user
  has_many :seats, :dependent => :destroy
  enum status: { reserve:'reserve', cancelled:'cancelled' }

   scope :available_dates, ->(params){ where("date LIKE ?","%#{params[:date]}%") }

   scope :owner_self_bus_reservations, ->(params, owner_id){ where("date LIKE ? and bus_id in (select id from buses where owner_id = ?)","%#{params[:date]}%", owner_id) }

end
