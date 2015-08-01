class AddProfilesToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :region, :text
  end
end
