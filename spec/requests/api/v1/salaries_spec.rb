require "rails_helper"

RSpec.describe "Salary Endpoint", type: :request do
  describe "GET /api/v1/employees/:id/salary" do
    let!(:employee) do
      Employee.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100000
      )
    end

    context "when employee exists" do
      before { get "/api/v1/employees/#{employee.id}/salary" }

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns salary breakdown" do
        json = JSON.parse(response.body)

        expect(json["gross"]).to eq("100000.0")
        expect(json["tds"]).to eq("10000.0")
        expect(json["net"]).to eq("90000.0")
      end
    end

    context "when employee does not exist" do
      before { get "/api/v1/employees/999999/salary" }

      it "returns not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns error message" do
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Employee not found")
      end
    end
  end
end
