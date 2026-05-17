class DropBookAuthors < ActiveRecord::Migration[8.1]
  def change
    drop_table :book_authors
  end
end
