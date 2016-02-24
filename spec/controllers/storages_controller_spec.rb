require 'rails_helper'

describe StoragesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @storages' do
      storage = create :storage
      get :index
      expect(assigns :storages).to include storage
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

  describe 'GET #show via XHR' do
    it 'assigns @storage' do
      storage = create :storage
      xhr :get, :show, id: storage.id
      expect(assigns :storage).to eq storage
    end

    it 'renders the show template' do
      storage = create :storage
      xhr :get, :show, id: storage.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR' do
    it 'assigns @storage' do
      storage = create :storage
      xhr :get, :edit, id: storage.id
      expect(assigns :storage).to eq storage
    end

    it 'renders the edit template' do
      storage = create :storage
      xhr :get, :edit, id: storage.id
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Storage from arguments' do
      storage = build :storage
      xhr :post, :create, storage: { title: storage.title, notes: storage.notes }
      expect(assigns :storage).to be_a Storage
      expect(flash[:success]).to match /Created new storage/
      expect(response).to redirect_to storages_path
    end
  end

  describe 'PATCH #update via XHR' do
    it 'updates specific Storage from arguments' do
      storage = create :storage
      storage.notes = 'Something different'
      xhr :patch, :update, id: storage.id, storage: { title: storage.title, notes: storage.notes }
      expect(flash[:success]).to match /Updated storage/
      expect(response).to redirect_to storages_path
    end
  end

  describe 'DELETE #destroy via XHR' do
    it 'deletes a specific Storage' do
      storage = create :storage
      xhr :delete, :destroy, id: storage.id
      expect(flash[:success]).to match /Deleted storage/
      expect(response).to redirect_to storages_path
    end
  end
end
