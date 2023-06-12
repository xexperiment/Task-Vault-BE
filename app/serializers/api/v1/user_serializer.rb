# frozen_string_literal: true

module Api
  module V1
    class UserSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :first_name, :last_name, :email
    end
  end
end
