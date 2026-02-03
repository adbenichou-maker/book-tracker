class BooksController < ApplicationController

require "open-uri"
require "json"

  def index
    @books = Book.order(title: :asc)

    @query = params[:query]

    if @query.present?
      @books = @books.where("LOWER(title) LIKE LOWER(?) OR LOWER(author) LIKE LOWER(?)", "%#{@query}%", "%#{@query}%")
    end

  end

  def show
    @book = Book.find(params[:id])
  end



  def search
    @query = params[:query]
    @books_from_api = []
    if @query.present?
      encoded_query = URI.encode_www_form_component(@query)
      url = "https://www.googleapis.com/books/v1/volumes?q=#{encoded_query}&maxResults=15&key=AIzaSyCsyUZ2H4hFoFy1Zsvcn6haztH8_CrLukY"
      response = URI.open(url).read
      puts "API Response: #{response.inspect}"
      @books_from_api = JSON.parse(response)["items"]
    end
  end

  def new
    @book = Book.new
    if params[:api_book].present?
      api_book = JSON.parse(params[:api_book])
      if api_book["volumeInfo"]["title"]
        @book_title = api_book["volumeInfo"]["title"]
      else
        @book_title = "Untitled"
      end
      if api_book["volumeInfo"]["authors"]
        @book_author = api_book["volumeInfo"]["authors"].join(", ")
      else
        @book_author = "Unknown Author"
      end
      if api_book["volumeInfo"]["publishedDate"]
        @book_publication_year = api_book["volumeInfo"]["publishedDate"][0..3]
      else

        @book_publication_year = "Unknown Publication Year"
      end
      if api_book.dig("volumeInfo", "industryIdentifiers")&.find { |id| id["type"] == "ISBN_13" }
        @book_isbn = api_book.dig("volumeInfo","industryIdentifiers")&.find { |id| id["type"] == "ISBN_13" }["identifier"]
      else
        @book_isbn = "Unknown ISBN"
      end
    end
  end

  def create

    if Book.exists?(isbn: book_params[:isbn])
      redirect_to root_path, alert: "This book is already in your collection."
      return
    end

    if book_params[:isbn].blank?
      if Book.find_by(title: book_params[:title], author: book_params[:author])
        redirect_to root_path, alert: "This book is already in your collection."
        return
      end
    end

    @book = Book.new(book_params)

    if @book.save
      @book.status = "Pending"
      redirect_to root_path, notice: "Book added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_status
    @book = Book.find(params[:id])
    new_status = @book.status == "Pending" ? "Read" : "Pending"
    @book.update(status: new_status)
    redirect_to root_path, notice: "Book status updated!"

  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to root_path, notice: "Book deleted!"
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :publication_year, :isbn, :status)
  end
end
