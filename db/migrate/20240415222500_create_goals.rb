class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :color
      t.string :icon
      t.decimal :amount
      t.date :due_date
      t.string :status
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
