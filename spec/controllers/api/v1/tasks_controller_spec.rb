require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      allow(controller).to receive(:current_user).and_return(user)
      FactoryBot.create(:task, user_id: user.id)
      FactoryBot.create(:task, user_id: user.id)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all tasks as JSON' do
      FactoryBot.create(:task, user_id: user.id)
      FactoryBot.create(:task, user_id: user.id)
      get :index
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe 'GET #show' do
    let(:task) { FactoryBot.create(:task) }

    it 'returns a successful response' do
      get :show, params: { id: task.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns the task as JSON' do
      get :show, params: { id: task.id }
      expect(JSON.parse(response.body)['data']['id']).to eq(task.id.to_s)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { task: FactoryBot.attributes_for(:task).merge!(user_id: user.id) } }

      it 'creates a new task' do
        expect do
          post :create, params: valid_params
        end.to change(Task, :count).by(1)
      end

      it 'returns the created task as response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the created task as JSON' do
        post :create, params: valid_params
        expect(JSON.parse(response.body)['data']['attributes']['description']).to eq(valid_params[:task][:description])
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { task: { description: '' } } }

      it 'does not create a new task' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Task, :count)
      end

      it 'returns the error messages as response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error messages as JSON' do
        post :create, params: invalid_params
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end
  end

  describe 'PATCH #update' do
    let(:task) { FactoryBot.create(:task) }

    context 'with valid parameters' do
      let(:valid_params) { { task: { description: 'Updated description' } } }

      it 'updates the task' do
        patch :update, params: { id: task.id, task: valid_params[:task] }
        expect(task.reload.description).to eq(valid_params[:task][:description])
      end

      it 'returns the updated task as response' do
        patch :update, params: { id: task.id, task: valid_params[:task] }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated task as JSON' do
        patch :update, params: { id: task.id, task: valid_params[:task] }
        expect(JSON.parse(response.body)['data']['attributes']['description']).to eq(valid_params[:task][:description])
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { task: { description: '' } } }

      it 'does not update the task' do
        patch :update, params: { id: task.id, task: invalid_params[:task] }
        expect(task.reload.description).not_to eq(invalid_params[:task][:description])
      end

      it 'returns the error messages as reponse' do
        patch :update, params: { id: task.id, task: invalid_params[:task] }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error messages as JSON' do
        patch :update, params: { id: task.id, task: invalid_params[:task] }
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:task) { FactoryBot.create(:task) }

    it 'returns the destroyed task as response' do
      delete :destroy, params: { id: task.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the destroyed task as JSON' do
      delete :destroy, params: { id: task.id }
      expect(JSON.parse(response.body)['message']).to eq('Successfully Deleted')
    end

    it 'returns an error response if deletion fails' do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: task.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns an error JSON if deletion fails' do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: task.id }
      expect(JSON.parse(response.body)['message']).to eq(task.errors.full_messages)
    end
  end
end
