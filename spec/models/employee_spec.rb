require "rails_helper"

RSpec.describe Employee, type: :model do
  subject(:employee) do
    described_class.new(
      full_name: "Ajay Jaitwal",
      job_title: "Developer",
      country: "India",
      salary: BigDecimal("100000.00")
    )
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(employee).to be_valid
    end

    it "is invalid without a full_name" do
      employee.full_name = nil
      expect(employee).not_to be_valid
      expect(employee.errors[:full_name]).to be_present
    end

    it "is invalid without a job_title" do
      employee.job_title = nil
      expect(employee).not_to be_valid
      expect(employee.errors[:job_title]).to be_present
    end

    it "is invalid without a country" do
      employee.country = nil
      expect(employee).not_to be_valid
      expect(employee.errors[:country]).to be_present
    end

    it "is invalid without a salary" do
      employee.salary = nil
      expect(employee).not_to be_valid
      expect(employee.errors[:salary]).to be_present
    end

    it "is invalid with salary less than or equal to 0" do
      employee.salary = 0
      expect(employee).not_to be_valid

      employee.salary = -100
      expect(employee).not_to be_valid
    end
  end

  describe "database constraints" do
    it "persists valid employee" do
      expect { employee.save! }.to change(described_class, :count).by(1)
    end
  end

  describe "normalization" do
    it "strips whitespace from country and job_title before validation" do
      employee.country = "  India  "
      employee.job_title = "  Developer  "
      employee.valid?

      expect(employee.country).to eq("India")
      expect(employee.job_title).to eq("Developer")
    end
  end

  describe "scopes" do
    before do
      described_class.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100_000
      )

      described_class.create!(
        full_name: "John",
        job_title: "developer",
        country: "india",
        salary: 120_000
      )
    end

    describe ".by_country" do
      it "returns employees regardless of case" do
        results = described_class.by_country("INDIA")
        expect(results.count).to eq(2)
      end
    end

    describe ".by_job_title" do
      it "returns employees regardless of case" do
        results = described_class.by_job_title("DEVELOPER")
        expect(results.count).to eq(2)
      end
    end
  end
end
