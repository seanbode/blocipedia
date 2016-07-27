class AddVisibilityToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :visibility, :integer
  end
end
