require "rails_helper"

RSpec.describe "Salary Metrics API", type: :request do
  describe "GET /api/v1/salary_metrics/country" do
    before do
      Employee.create!(full_name: "Ajay", job_title: "Dev", country: "India", salary: 100000)
      Employee.create!(full_name: "Raj", job_title: "Dev", country: "India", salary: 200000)
      Employee.create!(full_name: "John", job_title: "Dev", country: "USA", salary: 300000)
    end

    it "returns country salary metrics" do
      get "/api/v1/salary_metrics/country", params: { country: "India" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["country"]).to eq("India")
      expect(json["minimum"]).to eq("100000.0")
      expect(json["maximum"]).to eq("200000.0")
      expect(json["average"]).to eq("150000.0")
    end

    it "returns 404 if no employees found" do
      get "/api/v1/salary_metrics/country", params: { country: "France" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/v1/salary_metrics/job_title" do
    before do
      Employee.create!(full_name: "Ajay", job_title: "Developer", country: "India", salary: 100000)
      Employee.create!(full_name: "Raj", job_title: "Developer", country: "India", salary: 200000)
    end

    it "returns average salary by job title" do
      get "/api/v1/salary_metrics/job_title", params: { job_title: "Developer" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["job_title"]).to eq("Developer")
      expect(json["average"]).to eq("150000.0")
    end
  end
end
