class SalaryMetricsQuery
  def initialize(scope = Employee.all)
    @scope = scope
  end

  def by_country(country)
    records = @scope.by_country(country)

    return nil if records.empty?

    {
      country: country,
      minimum: records.minimum(:salary),
      maximum: records.maximum(:salary),
      average: records.average(:salary)
    }
  end

  def by_job_title(job_title)
    records = @scope.by_job_title(job_title)

    return nil if records.empty?

    {
      job_title: job_title,
      average: records.average(:salary)
    }
  end
end
