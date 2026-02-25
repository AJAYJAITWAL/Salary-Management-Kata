require "rails_helper"

RSpec.describe Payroll::SalaryCalculator do
  subject(:calculator) { described_class.new(employee) }

  let(:salary) { BigDecimal("100000.00") }

  describe "#call" do
    context "when employee is from India" do
      let(:employee) do
        Employee.new(
          full_name: "Ajay",
          job_title: "Developer",
          country: "India",
          salary: salary
        )
      end

      it "applies 10% deduction" do
        result = calculator.call

        expect(result[:gross]).to eq(BigDecimal("100000.00"))
        expect(result[:tds]).to eq(BigDecimal("10000.00"))
        expect(result[:net]).to eq(BigDecimal("90000.00"))
      end
    end

    context "when employee is from United States" do
      let(:employee) do
        Employee.new(
          full_name: "John",
          job_title: "Engineer",
          country: "United States",
          salary: salary
        )
      end

      it "applies 12% deduction" do
        result = calculator.call

        expect(result[:tds]).to eq(BigDecimal("12000.00"))
        expect(result[:net]).to eq(BigDecimal("88000.00"))
      end
    end

    context "when employee is from another country" do
      let(:employee) do
        Employee.new(
          full_name: "Maria",
          job_title: "Manager",
          country: "Brazil",
          salary: salary
        )
      end

      it "applies no deduction" do
        result = calculator.call

        expect(result[:tds]).to eq(BigDecimal("0"))
        expect(result[:net]).to eq(BigDecimal("100000.00"))
      end
    end

    context "when salary has decimal precision" do
      let(:employee) do
        Employee.new(
          full_name: "Test",
          job_title: "QA",
          country: "India",
          salary: BigDecimal("100000.55")
        )
      end

      it "rounds to 2 decimal places" do
        result = calculator.call

        expect(result[:tds]).to eq(BigDecimal("10000.06"))
        expect(result[:net]).to eq(BigDecimal("90000.49"))
      end
    end
  end
end
