# app/controllers/api/v1/csv_processor_controller.rb
require 'csv'


module Api
  module V1
    class CsvProcessorController < ApplicationController
    # class CsvProcessorController < ActionController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_api_key!

      def create
        event = Event.find(params[:event_id])
        csv_data = request.raw_post.presence || params[:file].read
        puts csv_data
        CsvProcessor.validate_structure!(csv_data)
        CsvProcessingJob.perform_later(event.id, csv_data)
        render json: { message: 'Processing started' }, status: :accepted

        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Event not found' }, status: :not_found
        rescue CsvProcessor::InvalidCSVError => e
          ErrorLog.create!(
            user: @current_api_key.user,
            event: event,
            message: e.message,
            details: { context: 'CSV validation' }
          )
          render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def authenticate_api_key!
        authenticate_or_request_with_http_token do |token, _opts|
          api_key = ApiKey.find_by(token: token, revoked: false)
          @current_api_key = api_key if api_key&.user&.admin?
        end
      end
    end
  end
end
