class CoauthorsController < ApplicationController
  before_action :set_coauthor, only: [:show, :edit, :update, :destroy]

  # GET /coauthors
  # GET /coauthors.json
  def index
    @coauthors = Coauthor.all
  end

  # GET /coauthors/1
  # GET /coauthors/1.json
  def show
  end

  # GET /coauthors/new
  def new
    @coauthor = Coauthor.new
  end

  # GET /coauthors/1/edit
  def edit
  end

  # POST /coauthors
  # POST /coauthors.json
  def create
    @coauthor = Coauthor.new(coauthor_params)

    respond_to do |format|
      if @coauthor.save
        format.html { redirect_to @coauthor, notice: 'Coauthor was successfully created.' }
        format.json { render :show, status: :created, location: @coauthor }
      else
        format.html { render :new }
        format.json { render json: @coauthor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coauthors/1
  # PATCH/PUT /coauthors/1.json
  def update
    respond_to do |format|
      if @coauthor.update(coauthor_params)
        format.html { redirect_to @coauthor, notice: 'Coauthor was successfully updated.' }
        format.json { render :show, status: :ok, location: @coauthor }
      else
        format.html { render :edit }
        format.json { render json: @coauthor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coauthors/1
  # DELETE /coauthors/1.json
  def destroy
    @coauthor.destroy
    respond_to do |format|
      format.html { redirect_to coauthors_url, notice: 'Coauthor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coauthor
      @coauthor = Coauthor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coauthor_params
      params.require(:coauthor).permit(:user_id, :book_id)
    end
end
