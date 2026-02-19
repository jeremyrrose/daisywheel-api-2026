class AllowNullSectionIdOnFeatures < ActiveRecord::Migration[6.0]
  def change
    change_column_null :features, :section_id, true
  end
end
