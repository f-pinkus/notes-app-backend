class NotesController < ApplicationController
  def index
    notes = Note.all

    render json: notes
  end

  def create
    note = Note.new(
      title: params[:title],
      body: params[:body]
    )

    if note.save
      render json: note
    else
      render json: { errors: note.errors.full_messages }, status: :bad_request
    end
  end

  def show
    note = Note.find_by(id: params[:id])

    render json: note
  end

  def update
    note = Note.find_by(id: params[:id])

    note.title = params[:title] || note.title,
    note.body = params[:body] || note.body
    
    if note.save
      render json: note
    else
      render json: { errors: note.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    note = Note.find_by(id: params[:id])

    note.destroy
    render json: { message: "Note deleted."}
  end
end
