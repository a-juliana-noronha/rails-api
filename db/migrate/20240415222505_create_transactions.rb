class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :transaction_type
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.integer :current_installment
      t.boolean :paid
      t.string :status, default: "active"
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :category, foreign_key: { to_table: :categories }
      t.belongs_to :goal, foreign_key: { to_table: :goals }
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :card, foreign_key: { to_table: :cards }
      t.belongs_to :payment_plan, foreign_key: { to_table: :payment_plans }
      t.belongs_to :reminder, foreign_key: { to_table: :reminders }

      t.timestamps
    end
  end
end
