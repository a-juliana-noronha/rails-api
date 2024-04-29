# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
User.create(name: 'Administrador', email: 'admin@test.com', password: '1234', role: 'admin')

# Create Categories
Category.create(name: 'Moradia',  monthly_limit: 1000, user_id: 1)
Category.create(name: 'Alimentação',  user_id: 1)

# Create Cost Centers
CostCenter.create(name: 'Casa',  user_id: 1)
CostCenter.create(name: 'Loja',  user_id: 1)

# Create Goals
Goal.create(name: 'Carro Zero', amount: 100000, due_date: '2024-12-31', user_id: 1)

# Create Cards
Card.create(name: 'Cartão de Crédito', issuer: 'MasterCard', limit: 5000, closing_day: 15, due_day: 20,  user_id: 1, cost_center_id: 1)
Card.create(name: 'Cartão de Crédito PJ', issuer: 'Visa', limit: 10000, closing_day: 5, due_day: 10,  user_id: 1, cost_center_id: 2)

# Create Accounts
Account.create(name: 'Conta Corrente - PF', account_type: 'checking', initial_amount: 10000,  user_id: 1, cost_center_id: 1)
Account.create(name: 'Conta Corrente - PJ', account_type: 'checking', initial_amount: 10000,  user_id: 1, cost_center_id: 2)

# Create Reminders
Reminder.create(name: 'Aluguel', transaction_type: 'expense', amount: 2000, due_day: 10, user_id: 1, category_id: 1, account_id: 1)

# Create Payment Plans
PaymentPlan.create(total_amount: 1000, total_installments: 10, days: 30, reminder: true, user_id: 1)

# Create Transactions
Transaction.create(name: 'Almoço', transaction_type: 'expense', amount: 50, date: '2024-04-10', paid: true, user_id: 1, category_id: 2, account_id: 1)
Transaction.create(name: 'Aluguel - Abril/24', transaction_type: 'expense', amount: 2000, date: '2024-04-15', user_id: 1, category_id: 1, account_id: 1, reminder_id: 1)