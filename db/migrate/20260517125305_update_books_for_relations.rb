class UpdateBooksForRelations < ActiveRecord::Migration[8.1]
  def change
    add_reference :books, :author, null: false, foreign_key: true
    remove_column :books, :author, :string
    remove_column :books, :genre, :string
  end
end
