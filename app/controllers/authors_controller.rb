class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    authors = Author.all 
    render json: authors, include: ['profile', 'posts', 'posts.tags']
  end

  def show
    author = Author.find_by(id: params[:id])
    if author
      render json: author, include: ['profile', 'posts', 'posts.tags']
    else 
      render json: { errors: "Author not found" }
    end
  end

  private

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

end