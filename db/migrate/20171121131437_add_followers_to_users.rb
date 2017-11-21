class AddFollowersToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followers, :string
  end
end
