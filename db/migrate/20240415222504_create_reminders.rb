class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :transaction_type
      t.decimal :amount
      t.integer :due_day
      t.string :status, default: "active"
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :category, foreign_key: { to_table: :categories }
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :card, foreign_key: { to_table: :cards }

      t.timestamps
    end
  end
end
