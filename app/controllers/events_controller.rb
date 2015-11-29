class EventsController < ApplicationController
  def create
    @user = current_user
    @event = @user.events.create(event_params)
    if @event.errors.present?
      flash[:alert] = "登録できませんでした #{@event.errors.full_messages.join(" ")}"
    else
      flash[:notice] = "登録しました"
    end
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
