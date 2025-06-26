class AddRevokedToApiKeys < ActiveRecord::Migration[8.0]
  def change
    add_column :api_keys, :revoked, :boolean, null: false, default: false
    add_index :api_keys, :revoked
    #Ex:- add_index("admin_users", "username")


  end
end
