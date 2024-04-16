class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :issuer
      t.string :icon
      t.string :color
      t.decimal :limit
      t.string :closing_date
      t.date :due_date
      t.string :status
      t.belongs_to :user, foreign_key: { to_table: :users }
      t.belongs_to :account, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
