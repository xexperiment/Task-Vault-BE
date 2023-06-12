# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, except: %i[index create]

      def index
        tasks = Task.where(user_id: current_user.id).order(created_at: :desc)
        render json: TaskSerializer.new(tasks).serialized_json
      end

      def show
        render json: TaskSerializer.new(@task).serialized_json
      end

      def create
        task = Task.new(task_params.merge!(user_id: current_user.id))
        if task.save
          render json: TaskSerializer.new(task).serialized_json, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: TaskSerializer.new(@task).serialized_json, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @task.destroy
          render json: { message: 'Successfully Deleted' }, status: :ok
        else
          render json: { message: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :status, :priority, :deadline)
      end
    end
  end
end
