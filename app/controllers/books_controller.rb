class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_non_author,only: [:destroy]
  before_action :check_coauthor,only: [:edit, :update]
  # GET /books
  # GET /books.json
  def index
    expires_in 5.minutes
    if params[:search]
      @books = Book.search(params[:search],current_user.id)
      @books = @books.paginate(page: params[:page], per_page: 12).order('created_at DESC')
    else

      book_list = Rails.cache.fetch(:book_list) do
        book_list = Book.where("user_id = ? OR ispublic = 1",current_user.id)
      end
=begin
slow_object = Rails.cache.fetch(:book_list) do
create_slow_object
end
=end
      #coauthored_book_list = Coauthor.book.where("user_id = ?",current_user.id)
      @books = book_list.paginate(page: params[:page], per_page: 12).order('created_at DESC')
      @books.each do |book|
        book.avgrating = average_rating(book.id)
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @cat = Category.find(@book.category)
    @reviews =Review.where("book_id = ?",@book.id)
    @categories = Category.all
    @coauthors = Coauthor.where("book_id = ? AND user_id != ?",@book.id,current_user.id)
    @rating = Rating.new
    @userid = current_user.id
    @avg_rating = average_rating(@book.id)
    @user_rating = user_rating(@book.id)
  end

  # GET /books/new
  def new
    @book = Book.new
    @categories = Category.all
    @users = User.where("id != ?",current_user.id)
  end

  # GET /books/1/edit
  def edit
    @categories = Category.all
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @categories = Category.all
    @users = User.all
    respond_to do |format|
      if @book.save
        @user = User.find(current_user.id)
        #ExampleMailer.sample_email(@user).deliver send e-mail regarding successful book creation
        @coauthors = params[:coauthors]
          if @coauthors != nil
          @coauthors.each do|coauthor|
            new_coauthor = Coauthor.new(user_id: coauthor, book_id: @book.id)
            new_coauthor.save
          end
        end
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @categories = Category.all
    @users = User.all
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :description, :picture, :user_id, :ispublic,:category,:coauthors,:avg_rating, :all_tags)
    end

    #check if user accessing book is the author . Allow destroy only to author
    def check_non_author
      book = Book.find(params[:id])
      if book.user_id != current_user.id
        redirect_to books_path, alert: "You are not main author of this book. Access denied"
      end
    end

    #check co_author to allow only edit access.
    def check_coauthor
      coauthors = Coauthor.where("book_id = ? AND user_id=?",params[:id],current_user.id)
      book = Book.where("id = ? AND user_id = ?",params[:id],current_user.id)
      if book.empty? #if user is author of book
        if coauthors.empty? #if user is coauthor of book
          redirect_to books_path, alert: "You are not author/coauthor of this book. Access denied."
        end
      end
    end

    #get average rating of book
    def average_rating(book_id)
     all_ratings = Rating.where("book_id = ?",book_id)
     count = 0
     total = 0
     all_ratings.each do |rating|
       count += 1
       total += rating.stars;
     end
     if count == 0
       return 0
     end
     total/count
    end

    #get rating for a book by a user
    def user_rating(book_id)
      user_rating = Rating.where("book_id = ? AND user_id = ?",book_id,current_user.id)
      if user_rating.empty?
        return 0
      end
      return user_rating[0].stars
    end
end
