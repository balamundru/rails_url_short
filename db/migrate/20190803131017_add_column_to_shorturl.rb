class AddColumnToShorturl < ActiveRecord::Migration[5.2]
  def change
    add_column :shorturls, :visits, :integer, default: 0
  end
end
