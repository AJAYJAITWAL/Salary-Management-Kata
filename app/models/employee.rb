class Employee < ApplicationRecord
  before_validation :normalize_fields

  scope :by_country, ->(country) {
    where("LOWER(country) = ?", country.downcase)
  }

  scope :by_job_title, ->(title) {
    where("LOWER(job_title) = ?", title.downcase)
  }

  validates :full_name, :job_title, :country, presence: true
  validates :salary,
            presence: true,
            numericality: { greater_than: 0 }

  private

  def normalize_fields
    self.country = country&.strip
    self.job_title = job_title&.strip
  end
end
