class AddDefaultToPagesOrderOnMagazines < ActiveRecord::Migration[6.0]
  def change
    change_column_default :magazines, :pages_order, from: nil, to: '[]'
  end
end
