# app/jobs/csv_processing_job.rb
class CsvProcessingJob < ApplicationJob
  queue_as :default

  def perform(csv_content, admin_id)
    admin = Admin.find(admin_id)
    
    CSV.parse(csv_content, headers: true).each.with_index(2) do |row, line_number|
      begin
        result = RaceResult.new(
          rider_name: row['rider_name'],
          finish_time: row['finish_time'],
          category: row['category'],
          event_name: row['event_name'], # Optional field
          processed_by: admin
        )
        
        result.save!
      rescue => e
        log_error(e, line_number, admin)
      end
    end
  end

  private

  def log_error(error, line_number, admin)
    ErrorLog.create!(
      admin: admin,
      message: "CSV Line #{line_number} Error: #{error.message}",
      details: {
        line_number: line_number,
        error: error.inspect,
        backtrace: error.backtrace.first(5)
      }
    )
  end
end