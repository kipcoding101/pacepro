# app/controllers/api/v1/csv_processor_controller.rb
module Api
  module V1
    class CsvProcessorController < ApplicationController
      before_action :authenticate_api_key!
      skip_before_action :verify_authenticity_token

      REQUIRED_COLUMNS = %w[rider_name finish_time category].freeze

      def create
        csv_content = request.body.read
        processor = CsvProcessor.new(csv_content, @api_key.admin)
        
        if processor.valid?
          processor.process
          render json: { 
            message: "CSV processing started",
            job_id: processor.job_id 
          }, status: :accepted
        else
          render json: { errors: processor.errors }, status: :unprocessable_entity
        end
      rescue => e
        log_error(e)
        render json: { error: "Internal server error" }, status: :internal_server_error
      end

      private

      def authenticate_api_key!
        api_key = request.headers['X-API-Key']
        @api_key = ApiKey.find_by(token: api_key)
        
        return if @api_key&.admin&.active?

        render json: { error: "Unauthorized" }, status: :unauthorized
      end

      def log_error(error)
        Rails.logger.error "CSV Processing Error: #{error.message}"
        ErrorLog.create!(
          admin: @api_key&.admin,
          message: error.message,
          backtrace: error.backtrace.join("\n")
        )
      end
    end
  end
end