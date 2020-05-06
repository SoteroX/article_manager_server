class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
