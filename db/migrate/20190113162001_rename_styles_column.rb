class RenameStylesColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :beers, :styles_id, :style_id
  end
end
