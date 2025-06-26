# app/jobs/csv_processing_job.rb
require 'csv'

class CsvProcessingJob < ApplicationJob
  queue_as :default

  def perform(event_id, csv_content)
    event = Event.find(event_id)
    clean = csv_content.force_encoding('UTF-8').sub(/\A\uFEFF/, '')

    CSV.parse(clean, headers: true).each_with_index do |row, index|
      next if row.to_h.values.all?(&:blank?)

      row_hash     = row.to_h
      race_number  = row_hash['RaceNumber']

      record = Result.where(event_id: event.id)
                  .where("raw_data ->> 'RaceNumber' = ?", race_number)
                  .first_or_initialize
      record.raw_data = row_hash

      begin
        record.save!
      rescue => e
        ErrorLog.create!(
          user: admin,
          event: event,
          message: "Line #{index + 2} error: #{e.message}",
          details: row_hash
        )
      end
    end
  end
end