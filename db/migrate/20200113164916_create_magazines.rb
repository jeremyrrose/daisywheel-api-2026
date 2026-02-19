class CreateMagazines < ActiveRecord::Migration[6.0]
  def change
    create_table :magazines do |t|
      t.string :title
      t.string :description
      t.string :header_image
      t.string :color_1
      t.string :color_2
      t.string :color_3
      t.string :color_4
      t.string :font_1
      t.string :font_2

      t.timestamps
    end
  end
end
