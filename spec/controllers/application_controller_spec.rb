require 'rails_helper'

describe ApplicationController, type: :controller do
  describe 'GET #index' do
    context 'when visited' do
      it 'displays text "Hello World"' do
        get :index

        expect(response).to render_template :index
      end
    end
  end
end
