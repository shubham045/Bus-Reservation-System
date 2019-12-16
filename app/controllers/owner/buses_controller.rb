class Owner::BusesController < ApplicationController

 before_action :set_bus, only: [:destroy, :edit, :update]
 before_action :require_owner

  def index
    @owner=Owner.find_by(user_id:current_user.id)
    @buses = @owner.buses.owner_bus_name(params)
  end

  def new
    @bus = Bus.new
  end

  def edit
  end

  def update
    if @bus.update(bus_params)
      redirect_to owner_buses_path , notice:"Bus updated successfully!"
    else
      render :edit, alert:"Bus was not updated!"
    end
  end

  def create
    @bus = Bus.new(bus_params)
    @owner=Owner.find_by(user_id:current_user.id)
    @bus.owner_id=@owner.id
    if @bus.save
      redirect_to owner_buses_path, notice:"Bus was successfully added"
    else
      redirect_to owner_buses_path, alert:"Please fill all fields"
    end
  end

  def destroy
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to owner_buses_path, notice: 'Bus was successfully deleted.' }
    end
  end

  private
    def require_owner
     unless current_user.owner?
        redirect_to root_path, alert:'Access Denied'
     end
    end

    def set_bus
      @bus = Bus.friendly.find(params[:id])
    end

    def bus_params
      params.require(:bus).permit(:name, :registration_no, :source, :destination, :total_seats, :status)
    end

end
