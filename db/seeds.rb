# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

book_1 = Book.create!(
  isbn: "9783161484100",
  title: "The Great Gatsby",
  author: "F. Scott Fitzgerald",
  publication_year: 1925,
  status: "Pending"
)

book_2 = Book.create!(
  isbn: "9780743273565",
  title: "To Kill a Mockingbird",
  author: "Harper Lee",
  publication_year: 1960,
  status: "Pending"
)

book_3 = Book.create!(
  isbn: "9780451524935",
  title: "1984",
  author: "George Orwell",
  publication_year: 1949,
  status: "Pending"
)
