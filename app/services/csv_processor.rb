# app/services/csv_processor.rb
class CsvProcessor
  include ActiveModel::Validations
  
  REQUIRED_COLUMNS = %w[rider_name finish_time category].freeze
  
  validate :required_columns_present
  validate :valid_csv_format

  def initialize(csv_content, admin)
    @csv_content = csv_content
    @admin = admin
    @errors = []
  end

  def process
    return false unless valid?
    
    CsvProcessingJob.perform_later(@csv_content, @admin.id)
  end

  def job_id
    @job_id ||= SecureRandom.uuid
  end

  private

  def required_columns_present
    return if csv_headers & REQUIRED_COLUMNS == REQUIRED_COLUMNS
    
    errors.add(:base, "CSV missing required columns: #{REQUIRED_COLUMNS.join(', ')}")
  end

  def valid_csv_format
    CSV.parse(@csv_content, headers: true) do |row|
      validate_row(row)
    end
  rescue CSV::MalformedCSVError => e
    errors.add(:base, "Invalid CSV format: #{e.message}")
  end

  def validate_row(row)
    REQUIRED_COLUMNS.each do |col|
      errors.add(:base, "Missing #{col} in row #{row}") if row[col].blank?
    end
    
    if row['finish_time'].present? && !numeric?(row['finish_time'])
      errors.add(:base, "Invalid finish_time in row #{row}")
    end
  end

  def csv_headers
    @csv_headers ||= CSV.parse(@csv_content, headers: true)&.headers || []
  end

  def numeric?(str)
    true if Float(str) rescue false
  end
end