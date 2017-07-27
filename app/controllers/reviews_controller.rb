class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id

      if @review.save
        redirect_to @review, notice: 'Review was successfully created.'
      else
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        redirect_to @review, notice: 'Review was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_url, notice: 'Review was successfully destroyed.'
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
