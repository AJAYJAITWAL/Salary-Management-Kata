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
      gross = employee.salary
      rate = DEDUCTION_RULES.fetch(employee.country.to_s.downcase, BigDecimal("0"))

      tds = (gross * rate).round(2)
      net = (gross - tds).round(2)

      {
        gross: gross,
        tds: tds,
        net: net
      }
    end

    private

    attr_reader :employee
  end
end
