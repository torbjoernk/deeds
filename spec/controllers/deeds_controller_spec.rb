require 'rails_helper'

describe DeedsController, type: :controller do
  shared_context 'Deed exists' do
    let(:deed) { create :deed }
  end

  describe 'GET #index', use_db: true do
    include_context 'Deed exists'

    it 'assigns @deeds' do
      get :index
      expect(assigns :deeds).to include deed
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe 'GET #new via XHR' do
    it 'renders the new template' do
      xhr :get, :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show via XHR', use_db: true do
    include_context 'Deed exists'

    it 'assigns @deed' do
      xhr :get, :show, id: deed.id
      expect(assigns :deed).to eq deed
    end

    it 'renders the show template' do
      xhr :get, :show, id: deed.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Deed exists'

    describe 'without additional parameters' do
      it 'assigns @deed' do
        xhr :get, :edit, id: deed.id
        expect(assigns :deed).to eq deed
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: deed.id
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Deed from arguments', use_db: true do
      deed = build :deed
      xhr :post, :create, deed: { title: deed.title, year: deed.year, description: deed.description }
      expect(assigns :deed).to be_a Deed
      expect(flash[:success]).to match /Created new deed/
      expect(response).to redirect_to deeds_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Deed exists'

    describe 'without additional parameters' do
      it 'updates specific Deed from arguments' do
        deed.description = 'Something different'
        xhr :patch, :update, id: deed.id, deed: { deed: deed.description }
        expect(flash[:success]).to match /Updated deed/
        expect(response).to redirect_to deeds_path
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Deed exists'

    it 'deletes a specific Deed' do
      xhr :delete, :destroy, id: deed.id
      expect(flash[:success]).to match /Deleted Deed/
      expect(response).to redirect_to deeds_path
    end
  end
end
