# Book Tracker

## Description

A Full Stack application that allows users to search for books using the Google Books API, catalog their reading lists, and track their reading status.

### Features

- **Search Books**: Query the Google Books API to find books by title or author.
- **Add Books**: Automatically populate book details from the API into a form and save it to your collection.
- **Track Status**: Mark books as "Pending" or "Read".
- **Manage Collection**: Delete unwanted books in your collection.

#### Technical stacks

- **Frontend**: HTML5, CSS3, Bootstrap
- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **External API**: Google Books API

## API Usage

This application uses the **Google Books API** to search for books. Here's what you need to know about the API usage:

### Google Books API

- **Purpose**: The Google Books API is used to search for books by title, author, or other metadata.
- **Endpoint**: https://www.googleapis.com/books/v1/volumes
- **Parameters**:
  - q: The search query (like the book title or author).
  - maxResults: The maximum number of results to return (default is 15 in this app).
  - key: Your Google Books API key.

### API Key

- **Requirement**: To use the Google Books API, you need an API key.
- **Setup**:
1. Go to the Google Cloud Console: (https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable the **Google Books API** for your project.
4. Create an API key under **APIs & Services > Credentials**.
5. Add the API key to your Rails application by replacing "YOUR_API_KEY" in the BooksController (see configuration instruction below).

- **Configuration in the Application**:
  - In the BooksController, replace the placeholder API key with your actual key in the search method, inside the url:

  def search
    @query = params[:query]
    @books_from_api = []
    if @query.present?
      encoded_query = URI.encode_www_form_component(@query)
      url = "https://www.googleapis.com/books/v1/volumes?q=#{encoded_query}&maxResults=15&key=YOUR_API_KEY"
      response = URI.open(url).read
      puts "API Response: #{response.inspect}"
      @books_from_api = JSON.parse(response)["items"]
    end
  end


## Executing program

### Steps
1. Clone the repository - in your terminal enter:
* git clone https://github.com/adbenichou-maker/book-tracker.git
* cd book-tracker

2. Set up the database - in your terminal enter:
* rails db\:create
* rails db\:migrate

3. Start the Rails server - in your terminal enter:
* rails server

4. Open local server - in your browser navigate to:
* http://localhost:3000


### Usage

1. Search for Books:
* Click the "Add new book" button and use the search bar to find new books by title or author.
* Click "Add this book" to pre-fill the form with book details.

2. Add a Book to Your Collection:
* Fill in any missing details if necessary.
* Click "Add this book" to save it to your collection.

3. Manage Your Collection:
* View all your books in the "My Book Collection" section.
* Use the search bar to retrieve books in your collection by title or author.
* Toggle the status between "Pending" and "Read".
* Delete books you no longer want in your collection.

## Technical Decisions

* Framework Choice: Rails was chosen for its straight forward naming convention which speeds up development and ensures maintainability.
* Frontend: Bootstrap was used for rapid UI development and classes reusability.
* Database: PostgresQL was chosen for simplicity in development.
* Turbo: Used for seamless page updates without full reloads, improving user experience.
