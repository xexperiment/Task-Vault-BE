# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  skip_before_action :authenticate_user!, only: :create

  private

  def respond_with(resource, _opts = {})
    if resource.errors.empty?
      render json: Api::V1::UserSerializer.new(resource).serialized_json, status: :ok
    else
      render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
