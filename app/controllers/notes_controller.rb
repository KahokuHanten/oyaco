class NotesController < ApplicationController
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
    Note.destroy(params[:id])
    redirect_to home_path
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
