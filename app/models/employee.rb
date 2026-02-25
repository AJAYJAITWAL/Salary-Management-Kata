class Employee < ApplicationRecord
  before_validation :normalize_fields

  private

  def normalize_fields
    self.country = country&.strip
    self.job_title = job_title&.strip
  end
end
