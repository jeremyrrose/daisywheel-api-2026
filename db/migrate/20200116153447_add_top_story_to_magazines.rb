class AddTopStoryToMagazines < ActiveRecord::Migration[6.0]
  def change
    add_column :magazines, :top_story, :integer, foreign_key: true, null: true
  end
end
