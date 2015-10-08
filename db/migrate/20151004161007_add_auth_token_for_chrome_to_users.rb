class AddAuthTokenForChromeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token_for_chrome, :string, index: true, unique: true
  end
end
