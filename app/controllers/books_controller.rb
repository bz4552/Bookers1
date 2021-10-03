class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end


  def create
    @book = Book.new(book_params)
    # binding.pry
    if @book.save
    redirect_to book_path(@book.id), notice: 'Book was successfully created.'
    else
    @books = Book.all
    flash.now[:alert] = 'It was an error.'
    render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
    flash.now[:danger] = 'It was an error.'
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end