class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.integer :employee_code_id
      t.string :employee_code
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :date_of_join
      t.float :salary
      t.timestamps
    end
  end
end
