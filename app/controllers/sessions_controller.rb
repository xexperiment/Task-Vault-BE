# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_action :authenticate_user!, only: :create

  def create
    reset_session
    super
  end

  private

  def respond_with(resource, _opts = {})
    if resource.errors.empty?
      render json: Api::V1::UserSerializer.new(resource).serialized_json, status: :ok
    else
      render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: 'logged out successfully'
    }, status: :ok
  end
end
