require 'rails_helper'

describe ArchivesController, type: :controller do
  shared_context 'Archive exists' do
    let(:archive) { create :archive }
  end

  describe 'GET #index' do
    include_context 'Archive exists'

    it 'assigns @archives' do
      get :index
      expect(assigns :archives).to include archive
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    describe 'filtered by associated Storage' do
      let(:storage) do
        storage = create :storage
        archive.storages << storage
        archive.save!
        storage
      end

      specify 'renders the index template' do
        get :index, storage_id: storage.id
        expect(response).to render_template :index
      end

      specify 'assigns @archives and @storage' do
        get :index, storage_id: storage.id
        expect(assigns :storage).to eq storage
        expect(assigns :archives).to include archive
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
    include_context 'Archive exists'

    it 'assigns @archive' do
      xhr :get, :show, id: archive.id
      expect(assigns :archive).to eq archive
    end

    it 'renders the show template' do
      xhr :get, :show, id: archive.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR' do
    include_context 'Archive exists'

    it 'assigns @archive' do
      xhr :get, :edit, id: archive.id
      expect(assigns :archive).to eq archive
    end

    it 'renders the edit template' do
      xhr :get, :edit, id: archive.id
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Archive from arguments' do
      archive = build :archive
      xhr :post, :create, archive: { title: archive.title, notes: archive.notes }
      expect(assigns :archive).to be_an Archive
      expect(flash[:success]).to match /Created new archive/
      expect(response).to redirect_to archives_path
    end
  end

  describe 'PATCH #update via XHR' do
    include_context 'Archive exists'

    it 'updates specific Archive from arguments' do
      archive.notes = 'Something different'
      xhr :patch, :update, id: archive.id, archive: { title: archive.title, notes: archive.notes }
      expect(flash[:success]).to match /Updated archive/
      expect(response).to redirect_to archives_path
    end
  end

  describe 'DELETE #destroy via XHR' do
    include_context 'Archive exists'

    it 'deletes a specific Archive' do
      xhr :delete, :destroy, id: archive.id
      expect(flash[:success]).to match /Deleted archive/
      expect(response).to redirect_to archives_path
    end
  end
end
