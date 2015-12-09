class NotesController < ApplicationController
  def new
    @user = current_user
    @event = @user.events.find(params[:event_id])
    @note = Note.new
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js {}
    end
  end

  def edit
    @note = Note.find(params[:id])
    @event = @note.event
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js {}
    end
  end

  def update
    @user = current_user
    @note = Note.find(params[:id])
    @event = @note.event
    @note.update_attributes(note_params)
    if @note.errors.present?
      flash[:alert] = "更新できませんでした #{@note.errors.full_messages.join(' ')}"
      redirect_to home_path
    else
      flash[:notice] = '更新しました'
      @user.point += 10
      @user.save
      redirect_to home_path anchor: "event#{@event.id}"
    end
  end

  def create
    @user = current_user
    @event = @user.events.find(params[:input_note_id])
    @note = @event.notes.create(note_params)
    if @note.errors.present?
      flash[:alert] = "登録できませんでした #{@note.errors.full_messages.join(' ')}"
      redirect_to home_path
    else
      flash[:notice] = '登録しました'
      @user.point += 10
      @user.save
      redirect_to home_path anchor: "event#{@event.id}"
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @event = @note.event
    @note.destroy
    redirect_to home_path anchor: "event#{@event.id}"
  end

  private

  def note_params
    params.require(:note).permit(:body, :image)
  end
end
