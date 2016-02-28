require 'rails_helper'

describe StoragesController, type: :controller do
  shared_context 'Storage exists' do
    before :each do
      @storage = create :storage
    end
  end

  describe 'GET #index' do
    include_context 'Storage exists'

    it 'assigns @storages' do
      get :index
      expect(assigns :storages).to include @storage
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end

    describe 'filtered by associated Archive' do
      before :each do
        @archive = create :archive
        @archive.storages << @storage
        @archive.save!
      end

      specify 'renders the index template' do
        get :index, archive_id: @archive.id
        expect(response).to render_template :index
      end

      specify 'assigns @storages and @archive' do
        get :index, archive_id: @archive.id
        expect(assigns :archive).to eq @archive
        expect(assigns :storages).to include @storage
      end
    end
  end

  describe 'GET #new via XHR' do
    it 'renders the new template' do
      xhr :get, :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show via XHR' do
    include_context 'Storage exists'

    it 'assigns @storage' do
      xhr :get, :show, id: @storage.id
      expect(assigns :storage).to eq @storage
    end

    it 'renders the show template' do
      xhr :get, :show, id: @storage.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR' do
    include_context 'Storage exists'

    it 'assigns @storage' do
      xhr :get, :edit, id: @storage.id
      expect(assigns :storage).to eq @storage
    end

    it 'renders the edit template' do
      xhr :get, :edit, id: @storage.id
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
    include_context 'Storage exists'

    it 'updates specific Storage from arguments' do
      @storage.notes = 'Something different'
      xhr :patch, :update, id: @storage.id, storage: { title: @storage.title, notes: @storage.notes }
      expect(flash[:success]).to match /Updated storage/
      expect(response).to redirect_to storages_path
    end
  end

  describe 'DELETE #destroy via XHR' do
    include_context 'Storage exists'

    it 'deletes a specific Storage' do
      xhr :delete, :destroy, id: @storage.id
      expect(flash[:success]).to match /Deleted storage/
      expect(response).to redirect_to storages_path
    end
  end
end
