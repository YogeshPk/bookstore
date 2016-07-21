class AddIspublicToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :ispublic, :boolean
  end
end
