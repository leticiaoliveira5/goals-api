require 'rails_helper'

describe 'TasksController', type: :request do
  context 'index' do
    it 'should return status ok' do
      get api_tasks_path

      expect(response).to have_http_status(200)
    end
  end
end