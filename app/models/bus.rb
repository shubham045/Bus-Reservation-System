class Bus < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]


  validates :name, presence: true
  validates :registration_no, presence: true
  validates :source, presence: true
  validates :destination, presence: true
  validates :total_seats, presence: true

  belongs_to :owner
  has_many :reservations, :dependent => :destroy


  scope :avilable_buses_for_all_reservations, ->(params){ joins(owner: :user).where("buses.name LIKE ? and source LIKE ? and destination LIKE ? and buses.status = ? AND users.status = 'approve'", "%#{params[:name]}%","%#{params[:source]}%", "%#{params[:destination]}%" ,true) }

  scope :owner_bus_name, ->(params){ where("name LIKE ? ", "%#{params[:name]}%") }

  scope :admin_all_bus, ->(params){ where("name LIKE ? and source LIKE ? and destination LIKE ? ", "%#{params[:name]}%","%#{params[:source]}%", "%#{params[:destination]}%" ) }

end
