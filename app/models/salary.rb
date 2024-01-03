class Salary < ApplicationRecord
	belongs_to :employee

	def self.calculate_income_tax(income)
  		case income
  		when 0..250000
    	  tax = 0
  		when 250001..500000
    	  tax = (income - 250000) * 0.05
  		when 500001..1000000
    	  tax = 250000 * 0.05 + (income - 500000) * 0.1
  		else
    	  tax = 250000 * 0.05 + 500000 * 0.1 + (income - 1000000) * 0.2
  		end
  		return tax
	end

	def self.cess(income)
		(income > 2500000) ? (income * 0.02) : 0  
	end
end
