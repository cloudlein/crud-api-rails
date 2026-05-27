class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    collection = Author.all
    @pagy, @author = paginate(collection)
  end

  def show
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(param_author)
    unless @author.valid?
      return render json: { errors: @author.errors.full_messages },
             status: :unprocessable_entity
    end
    @author.save!
    render :create, status: :created
  end

  def update
    @author = Author.find(params[:id])
    unless @author.update(param_author)
      return render json: { errors: @author.errors.full_messages} , 
      status: :unprocessable_entity
    end
    render :update, status: :ok
  end

  def destroy
    Author.find(params[:id]).destroy
    head :no_content
  end

  private

  def param_author
    params.permit(
      :first_name,
      :last_name,
      :pen_name,
      :birth_date,
      :bio,
      :nationality,
    )
  end
end
