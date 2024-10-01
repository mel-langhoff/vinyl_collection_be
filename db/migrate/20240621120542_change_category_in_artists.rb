class ChangeCategoryInArtists < ActiveRecord::Migration[6.1]
  def change
    change_column :artists, :category, :string
  end
end
