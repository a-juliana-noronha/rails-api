class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.string :color
      t.string :status, default: "active"
      t.decimal :monthly_limit
      t.belongs_to :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
