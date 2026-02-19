class RenameStaticOnArticlesToStaticPage < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :static, :static_page
  end
end
