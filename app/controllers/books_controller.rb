class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
        redirect_to books_path
        return
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render :edit
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

end
