# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |resource|
      render json: { message: "Record(s) not found: #{resource.model.presence || resource}" },
             status: :not_found
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from ArgumentError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
