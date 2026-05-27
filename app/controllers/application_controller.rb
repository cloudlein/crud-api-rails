# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,                 with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid,                  with: :render_unprocessable_entity_response
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :render_bad_request_response

  private

  def render_not_found_response(e)
    model_name = e.model&.humanize || "Record"
    render json: { error: "#{model_name} not found" }, status: :not_found
  end

  def render_bad_request_response
    render json: { error: "Invalid JSON format" }, status: :bad_request
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages },
           status: :unprocessable_entity
  end
end
