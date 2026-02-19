class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.references :section, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :priority

      t.timestamps
    end
  end
end
