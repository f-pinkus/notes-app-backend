class NotesController < ApplicationController
  before_action :authenticate_user

  def index
    @notes = current_user.notes

    render :index
  end

  def create
    @note = Note.new(
      title: params[:title],
      body: params[:body],
      user_id: current_user.id
    )

    if @note.save
      render :show
    else
      render json: { errors: @note.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @note = current_user.notes.find_by(id: params[:id])

    if @note
      render :show
    else
      render json: { error: "Note not found" }, status: :bad_request
    end
  end

  def update
    @note = Note.find_by(id: params[:id])

    @note.title = params[:title] || @note.title,
    @note.body = params[:body] || @note.body
    
    if @note.save
      render :show
    else
      render json: { errors: @note.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])

    @note.destroy
    render json: { message: "Note deleted."}
  end
end
