class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :account_type
      t.string :color
      t.string :icon
      t.decimal :initial_amount, default: 0
      t.string :status
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
