module Payroll
  class SalaryCalculator
    DEDUCTION_RULES = {
      "india" => BigDecimal("0.10"),
      "united states" => BigDecimal("0.12")
    }.freeze

    def initialize(employee)
      @employee = employee
    end

    def call
      {
        gross: gross_salary,
        tds: tds_amount,
        net: net_salary
      }
    end

    private

    attr_reader :employee

    def gross_salary
      employee.salary
    end

    def deduction_rate
      DEDUCTION_RULES.fetch(normalized_country, BigDecimal("0"))
    end

    def normalized_country
      employee.country.to_s.strip.downcase
    end

    def tds_amount
      (gross_salary * deduction_rate).round(2)
    end

    def net_salary
      (gross_salary - tds_amount).round(2)
    end
  end
end
