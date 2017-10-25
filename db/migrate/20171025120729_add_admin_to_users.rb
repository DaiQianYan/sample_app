class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    # add_column :users, :admin, :boolean
    # The migration to add a boolean admin attribute to users.
    add_column :users, :admin, :boolean, default: false
  end
end
