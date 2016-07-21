class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(rating_params)
    @old_rating = Rating.where("book_id = ? AND user_id = ?",@rating.book_id,@rating.user_id)
    p @old_rating
    respond_to do |format|
      if @old_rating.empty?
        if @rating.save
          format.html { redirect_to :back, notice: 'You have successfully rated this book' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { redirect_to :back ,notice: 'Error while saving your rating.'}
          format.json { render json: @rating.errors, status: :unprocessable_entity }
        end
      else
        if @old_rating.update(rating_params)
          format.html { redirect_to :back, notice: 'You have successfully updated rating' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { redirect_to :back ,notice: 'Error while saving your rating.'}
          format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:user_id, :book_id, :stars)
    end
end
