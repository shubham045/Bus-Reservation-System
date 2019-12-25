class Owner::ReservationsController < ApplicationController

  # before_action :require_owner
  def index
    binding.pry
    if params[:bus_id]
      #For owner/buses/bus_id/reservations
      @bus=Bus.friendly.find(params[:bus_id])
      @reservations= @bus.reservations.available_dates(params)

    else
      #For owner/reservations
      @owner=Owner.find_by(user:current_user)
      @reservations= Reservation.owner_self_bus_reservations(params, @owner.id)
    end
  end

  def destroy
    @reservation=Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to  owner_reservations_path, notice:"Reservation successfully deleted!"
    else
      redirect_to  owner_reservations_path, alert:'Reservation not deleted!'
    end
  end

  private
  
    def require_owner
      unless current_user.owner?
        redirect_to root_path, notice:'Access Denied'
      end
    end

end
