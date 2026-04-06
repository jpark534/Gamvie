class CreateMoodSearches < ActiveRecord::Migration[8.1]
  def change
    create_table :mood_searches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :mood_input
      t.string :detected_moods
      t.integer :movies_matched

      t.timestamps
    end
  end
end
