class AddFeaturedToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :top_story, :integer, foreign_key: true
  end
end
