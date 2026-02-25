require "rails_helper"

RSpec.describe "Api::V1::Employees", type: :request do
  let(:valid_params) do
    {
      employee: {
        full_name: "Ajay Jaitwal",
        job_title: "Developer",
        country: "India",
        salary: 100_000.00
      }
    }
  end

  let(:invalid_params) do
    {
      employee: {
        full_name: nil,
        job_title: "",
        country: "",
        salary: -100
      }
    }
  end

  describe "GET /api/v1/employees" do
    before do
      Employee.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100_000
      )
    end

    it "returns all employees" do
      get "/api/v1/employees"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json.size).to eq(1)
      expect(json.first["full_name"]).to eq("Ajay")
    end
  end

  describe "GET /api/v1/employees/:id" do
    let!(:employee) do
      Employee.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100_000
      )
    end

    it "returns the employee" do
      get "/api/v1/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["id"]).to eq(employee.id)
      expect(json["full_name"]).to eq("Ajay")
    end

    it "returns 404 when employee not found" do
      get "/api/v1/employees/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/employees" do
    it "creates an employee with valid params" do
      expect {
        post "/api/v1/employees", params: valid_params
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)

      expect(json["full_name"]).to eq("Ajay Jaitwal")
    end

    it "returns 422 with invalid params" do
      post "/api/v1/employees", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /api/v1/employees/:id" do
    let!(:employee) do
      Employee.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100_000
      )
    end

    it "updates the employee" do
      patch "/api/v1/employees/#{employee.id}", params: {
        employee: { job_title: "Senior Developer" }
      }

      expect(response).to have_http_status(:ok)
      expect(employee.reload.job_title).to eq("Senior Developer")
    end

    it "returns 404 if employee does not exist" do
      patch "/api/v1/employees/999999", params: valid_params

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/v1/employees/:id" do
    let!(:employee) do
      Employee.create!(
        full_name: "Ajay",
        job_title: "Developer",
        country: "India",
        salary: 100_000
      )
    end

    it "deletes the employee" do
      expect {
        delete "/api/v1/employees/#{employee.id}"
      }.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 if employee does not exist" do
      delete "/api/v1/employees/999999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
