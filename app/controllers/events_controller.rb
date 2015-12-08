class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]

  def new
    @user = current_user
    @event = Event.new
  end

  def create
    @user = current_user
    @event = @user.events.create(event_params)
    if @event.errors.present?
      flash[:alert] = "登録できませんでした #{@event.errors.full_messages.join(" ")}"
      redirect_to home_path
    else
      flash[:notice] = "登録しました"
      @user.point += 50
      @user.save
      redirect_to home_path anchor: "event#{@event.id}"
    end
  end

  def edit
  end

  def update
    @user = current_user
    @event.update(event_params)
    if @event.errors.present?
      flash[:alert] = "更新できませんでした #{@event.errors.full_messages.join(" ")}"
      redirect_to home_path
    else
      flash[:notice] = "更新しました"
      @user.point += 10
      @user.save
      redirect_to home_path anchor: "event#{@event.id}"
    end
  end

  def destroy
    @event.destroy
    redirect_to home_path
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date, :name, :kind, :image)
  end
end
