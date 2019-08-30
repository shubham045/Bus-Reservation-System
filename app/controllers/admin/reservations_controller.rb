class Admin::ReservationsController < ApplicationController

  before_action :require_admin

def index
  #For admin/reservations
  if params[:owner_id].blank? and params[:bus_id].blank?
      @reservations= Reservation.available_dates(params)

  #For admin/owners/:owner_id/reservations
  elsif params[:owner_id] and params[:bus_id].blank?
    @owner = Owner.find(params[:owner_id])
    @reservations = Reservation.owner_self_bus_reservations(params, @owner)

  #For admin/owners/:owner_id/buses/:bus_id/reservations
  else
    @bus =Bus.friendly.find(params[:bus_id])
    @reservations= @bus.reservations.available_dates(params)
  end
end


  private
    def require_admin
      unless current_user.admin?
        redirect_to root_path, notice:'Access Denied'
      end
    end

end
