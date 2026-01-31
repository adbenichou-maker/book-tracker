class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title, null: false
      t.string :author, null: false
      t.integer :publication_year
      t.string :status, default: "Pending"

      t.timestamps
    end
  end
end
