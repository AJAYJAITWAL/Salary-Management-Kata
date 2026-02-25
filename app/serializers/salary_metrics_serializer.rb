class SalaryMetricsSerializer
  def self.country(result)
    {
      country: result[:country],
      minimum: format_decimal(result[:minimum]),
      maximum: format_decimal(result[:maximum]),
      average: format_decimal(result[:average])
    }
  end

  def self.job_title(result)
    {
      job_title: result[:job_title],
      average: format_decimal(result[:average])
    }
  end

  def self.format_decimal(value)
    value&.to_d&.to_s
  end

  private_class_method :format_decimal
end
