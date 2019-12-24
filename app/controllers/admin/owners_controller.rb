class Admin::OwnersController < ApplicationController

  before_action :require_admin
  def index
    @owners = Owner.all
  end

  def update_owner
    @owner = Owner.find(params[:id])
    if @owner.user.approve?
      @owner.user.status='suspend'
    else
      @owner.user.status='approve'
    end
      if @owner.user.save
        redirect_to admin_owners_path, notice:"Owner Successfully Updated!"
      else
        redirect_to admin_owners_path, danger:'Something wrong!'
       end
  end

  def destroy
      @owner = Owner.find(params[:id])
      @user= @owner.user
          if @owner.destroy
            if @user.destroy
              redirect_to admin_owners_path, notice:'Owner successfully deleted!'
            end
          else
              edirect_to admin_owners_path, notice:'Owner not deleted!'
          end
  end

   private

    def require_admin
           unless current_user.admin?
               redirect_to root_path, notice:'Access Denied'
           end
    end

end
