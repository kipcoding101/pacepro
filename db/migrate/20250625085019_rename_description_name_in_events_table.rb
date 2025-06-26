class RenameDescriptionNameInEventsTable < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :descrption, :description
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")

  end
end
