class Admin::BusesController < ApplicationController

  before_action :require_admin

  def index
    if params[:owner_id]
      #For admin/owners/:owner_id/buses
      owner= Owner.find(params[:owner_id])
      @buses= Bus.all.where(owner:owner)
    else
      #For admin/buses
      @buses=Bus.admin_all_bus(params)
    end
  end

  private

    def require_admin
      unless current_user.admin?
        redirect_to root_path, notice:'Access Denied'
      end
    end

end
