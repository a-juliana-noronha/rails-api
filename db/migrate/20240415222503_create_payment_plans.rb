class CreatePaymentPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_plans do |t|
      t.decimal :total_amount
      t.decimal :total_installments
      t.integer :days
      t.boolean :reminder
      t.string :status, default: "active"
      t.belongs_to :card, foreign_key: { to_table: :cards }
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
