class BooksController < ApplicationController
  

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def top
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def new
   @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
  # if @book.update(book_params)
  #   redirect_to book_path
  # else
  #   render 'edit'
  # end
   if @book.update(book_params)
   redirect_to book_path(@book.id), notice: 'Book was successfully created.'
  else
    render :edit
  end
  end


  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  # if @book.save
  # 	redirect_to book_path(@book.id)
  # else
  #   @books = Book.all
  #   @user = current_user
  #   render  'users/show'
  # end
  if @book.save
    # ＠を追加
    redirect_to book_path(@book.id), notice: 'Book was successfully created.'
     else
    @books = Book.all
    @user = current_user
    render  'users/show'
  end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    book = Book.find(params[:id])
    if book.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end
end


