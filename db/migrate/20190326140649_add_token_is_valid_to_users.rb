class AddTokenIsValidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token_is_valid, :boolean, default: false
  end
end
