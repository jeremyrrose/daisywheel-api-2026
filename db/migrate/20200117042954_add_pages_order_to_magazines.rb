class AddPagesOrderToMagazines < ActiveRecord::Migration[6.0]
  def change
    add_column :magazines, :pages_order, :text
  end
end
