class EventsController < ApplicationController
  def create
    @user = current_user
    @event = @user.events.create(event_params)
    redirect_to home_path
  end

  def destroy
    Event.destroy(params[:id])
    redirect_to home_path
  end

  private
  def event_params
    params.require(:event).permit(:date, :name)
  end
end
