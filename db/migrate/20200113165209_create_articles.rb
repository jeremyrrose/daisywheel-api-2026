class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :dek
      t.string :content
      t.string :image
      t.string :caption
      t.string :credit
      t.string :url
      t.boolean :published
      t.boolean :static

      t.timestamps
    end
  end
end
