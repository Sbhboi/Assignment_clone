class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :publication_year
      t.text :description
      t.boolean :recommended, default: false
      t.timestamps
    end
  end
end
