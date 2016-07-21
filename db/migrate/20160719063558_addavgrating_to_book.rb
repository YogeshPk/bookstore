class AddavgratingToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :avgrating, :integer
  end
end
