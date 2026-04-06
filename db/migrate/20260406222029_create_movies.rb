class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.string :mood_tags
      t.string :description
      t.string :poster_url
      t.float :rating

      t.timestamps
    end
  end
end
