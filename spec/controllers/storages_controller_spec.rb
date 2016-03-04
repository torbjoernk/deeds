require 'rails_helper'

describe StoragesController, type: :controller do
  shared_context 'Storage exists' do
    let(:storage) { create :storage }
  end

  describe 'GET #index', use_db: true do
    include_context 'Storage exists'

    it 'assigns @storages' do
      get :index
      expect(assigns :storages).to include storage
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end

    describe 'filtered by associated Archive', use_db: true do
      let(:archive) do
        archive = create :archive
        archive.storages << storage
        archive.save!
        archive
      end

      specify 'renders the index template' do
        get :index, archive_id: archive.id
        expect(response).to render_template :index
      end

      specify 'assigns @storages and @archive' do
        get :index, archive_id: archive.id
        expect(assigns :archive).to eq archive
        expect(assigns :storages).to include storage
      end
    end
  end

  describe 'GET #new via XHR' do
    it 'renders the new template' do
      xhr :get, :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show via XHR', use_db: true do
    include_context 'Storage exists'

    it 'assigns @storage' do
      xhr :get, :show, id: storage.id
      expect(assigns :storage).to eq storage
    end

    it 'renders the show template' do
      xhr :get, :show, id: storage.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Storage exists'

    describe 'without additional parameters' do
      it 'assigns @storage' do
        xhr :get, :edit, id: storage.id
        expect(assigns :storage).to eq storage
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: storage.id
        expect(response).to render_template :edit
      end
    end

    describe 'with :sub_action => :refresh_nested' do
      let(:archive) { create :archive }

      it 'assigns @free_sources' do
        xhr :get, :edit, id: storage.id, sub_action: :refresh_nested
        expect(assigns :unassociated).to include :archives
      end

      it 'renders the form refresh template' do
        xhr :get, :edit, id: storage.id, sub_action: :refresh_nested
        expect(response).to render_template 'storages/form/_refresh'
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Storage from arguments', use_db: true do
      storage = build :storage
      xhr :post, :create, storage: { title: storage.title, notes: storage.notes }
      expect(assigns :storage).to be_a Storage
      expect(flash[:success]).to match /Created new storage/
      expect(response).to redirect_to storages_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Storage exists'

    describe 'without additional parameters' do
      it 'updates specific Storage from arguments' do
        storage.notes = 'Something different'
        xhr :patch, :update, id: storage.id, storage: { title: storage.title, notes: storage.notes }
        expect(flash[:success]).to match /Updated storage/
        expect(response).to redirect_to storages_path
      end
    end

    describe 'with :sub_action => :associate' do
      describe 'and :archive_id set' do
        let(:archive) { create :archive }

        describe 'an un-associated Archive' do
          specify 'associates the Storage to the Archive' do
            expect(Storage.find(storage.id).archives).not_to include archive
            xhr :patch, :update, id: storage.id, sub_action: :associate, archive_id: archive.id
            expect(Storage.find(storage.id).archives).to include archive
          end
        end

        describe 'an already associated Archive' do
          specify 'raises error' do
            storage.archives << archive
            expect(Storage.find(storage.id).archives).to include archive
            expect {
              xhr :patch, :update, id: storage.id, sub_action: :associate, archive_id: archive.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end
    end

    describe 'with :sub_action => :deassociate' do
      describe 'and :archive_id' do
        let(:archive) { create :archive }

        describe 'set to an associated Archive' do
          specify 'removes this association' do
            storage.archives << archive
            expect(Storage.find(storage.id).archives).to include archive
            xhr :patch, :update, id: storage.id, sub_action: :deassociate, archive_id: archive.id
            expect(Storage.find(storage.id).archives).not_to include archive
          end
        end
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Storage exists'

    it 'deletes a specific Storage' do
      xhr :delete, :destroy, id: storage.id
      expect(flash[:success]).to match /Deleted Storage/
      expect(response).to redirect_to storages_path
    end
  end
end
