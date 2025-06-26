# app/services/csv_processor.rb
require 'csv'

class CsvProcessor
  class InvalidCSVError < StandardError; end

  REQUIRED_COLUMNS = [
    "RaceNumber", "CardNumbers", "MembershipNumbers", "Name (Free Format)",
    "Category", "Club", "Country", "CourseClass", "StartTime", "FinishTime",
    "RaceTime", "NonCompetitive", "Position", "Status", "Handicap",
    "PenaltyScore", "ManualScoreAdjust", "FinalScore", "HandicapTime",
    "HandicapScore", "AwardLevel", "EntrySystemIDs", "Eligibility",
    "JourneyTime", "ExcludedExcess", "BehindTime", "GenderDOB", "Forenames",
    "Surnames", "STAGE 1 Time", "STAGE 1 Pos", "STAGE 2 Time", "STAGE 2 Pos",
    "STAGE 3 Time", "STAGE 3 Pos", "STAGE 4 Time", "STAGE 4 Pos",
    "STAGE 5 Time", "STAGE 5 Pos", "STAGE 6 Time", "STAGE 6 Pos",
    "STAGE 7 Time", "STAGE 7 Pos", "STAGE 8 Time", "STAGE 8 Pos",
    "LiaisonExcess"
  ].freeze

  def self.validate_structure!(csv_data)
    # 1) Force the string into UTF-8 (no incompatible BINARY)
    utf8_data = csv_data.force_encoding('UTF-8')
    # 2) Remove any leading BOM character (Unicode FEFF)
    clean_data = utf8_data.sub(/\A\uFEFF/, '')

    # 3) Parse with headers
    csv     = CSV.new(clean_data, headers: true)
    headers = csv.first&.headers || []

    # 4) Check for missing columns
    missing = REQUIRED_COLUMNS - headers
    if missing.any?
      raise InvalidCSVError, "Missing columns: #{missing.join(', ')}"
    end

    true
  rescue CSV::MalformedCSVError => e
    raise InvalidCSVError, "Invalid CSV format: #{e.message}"
  end
end
