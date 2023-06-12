# frozen_string_literal: true

module Api
  module V1
    class TaskSerializer
      include FastJsonapi::ObjectSerializer

      attributes :id, :title, :description, :status, :priority, :deadline
    end
  end
end
