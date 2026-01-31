Rails.application.routes.draw do

  root to: "books#index"

  get "/search", to: "books#search", as: "search_books"
  get "/new", to: "books#new", as: "new_book"
  post "/create", to: "books#create"
  patch "books/:id/update_status", to: "books#update_status", as: "update_book_status"
  get "books/:id/edit", to: "books#edit", as: "edit_book"
  patch "books/:id", to: "books#update"
  delete "books/:id", to: "books#destroy" , as: "delete_book"
end
