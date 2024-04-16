class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :transaction_type
      t.decimal :amount
      t.date :date
      t.date :accrual_date
      t.boolean :reminder
      t.string :status
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :category, foreign_key: { to_table: :categories }
      t.belongs_to :goal, foreign_key: { to_table: :goals }
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :credit_card, foreign_key: { to_table: :credit_cards }

      t.timestamps
    end
  end
end
