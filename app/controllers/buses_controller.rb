class BusesController < ApplicationController


  def index
          @buses=Bus.avilable_buses_for_all_reservations(params)
  end

end
