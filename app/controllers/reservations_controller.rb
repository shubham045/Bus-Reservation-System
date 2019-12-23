class ReservationsController < ApplicationController

  helper_method :available_seat?
  def index
    @reservations=current_user.reservations.where(status:'reserve')
  end

  def show
  end

  def new
    @bus = Bus.friendly.find(params[:bus_id])
    @reservation = @bus.reservations.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @bus = Bus.friendly.find(params[:bus_id])
    @reservation = @bus.reservations.new(reservation_params)
    @reservation.user_id = current_user.id
      if @reservation.save
        reserved_seat
        redirect_to root_path, notice: 'Reservation was successfully created.'
      else
        redirect_to root_path, alert: 'Reservation not created.'
      end
  end

  def reserved_seat
     reser = params["reservation"]
     book = reser[:seat_ids]
     seat_nos= book.select {|n|  n!='0' }
     seat_nos.each do |s_n|
       @reservation.seats.create(seat_no:s_n)
     end
  end

  def cancle_reservation
    @reservation = Reservation.find(params[:id])
    @reservation.status='cancelled'
      if @reservation.save
          redirect_to reservations_path, alert:"Reservation cancelled successfully!"
      else
          redirect_to reservations_path, alert:"Something went wrong!"
      end
  end

    def new_seat
        @bus = Bus.find(params[:bus_id])
        @reservation = @bus.reservations.new
        @date = params[:date]
        @total_seats = Array(1..@bus.total_seats)
        @count_seat = 0
        for i in 1..@total_seats.size do
            @count_seat += available_seat?(i,@date) ? 1 : 0
        end
    end

    def available_seat?(seat_num,date)
        reservation = @bus.reservations.where(date:date)
        reservation.each do |check_reservation|
          seats = check_reservation.seats
            if seats.map(&:seat_no).include?(seat_num)
              return false
            end
        end
        return true
    end



    private

      def reservation_params
        params.require(:reservation).permit(:date, :no_of_seats)
      end

end