class CreateSalaries < ActiveRecord::Migration[6.1]
  def change
    create_table :salaries do |t|
      t.float :amount
      t.integer :employee_id
      t.datetime :credit_date
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
