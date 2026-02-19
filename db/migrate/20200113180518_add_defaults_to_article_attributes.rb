class AddDefaultsToArticleAttributes < ActiveRecord::Migration[6.0]
  def change
    change_column_default :articles, :static, from: nil, to: false
    change_column_default :articles, :published, from: nil, to: false
  end
end
