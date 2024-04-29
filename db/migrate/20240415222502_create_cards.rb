class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :issuer
      t.string :icon
      t.string :color
      t.decimal :limit
      t.integer :closing_day
      t.integer :due_day
      t.boolean :is_default, default: false
      t.string :status, default: "active"
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :cost_center, foreign_key: { to_table: :cost_centers }
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
