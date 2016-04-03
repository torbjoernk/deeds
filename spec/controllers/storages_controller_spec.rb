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

    describe 'filtered by associated Collection', use_db: true do
      let(:collection) do
        collection = create :collection
        collection.storages << storage
        collection.save!
        collection
      end

      specify 'renders the index template' do
        get :index, collection_id: collection.id
        expect(response).to render_template :index
      end

      specify 'assigns @storages and @collection' do
        get :index, collection_id: collection.id
        expect(assigns :collection).to eq collection
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
      let(:collection) { create :collection }

      it 'assigns @free_documents' do
        xhr :get, :edit, id: storage.id, sub_action: :refresh_nested
        expect(assigns :unassociated).to include :collections
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
      describe 'and :collection_id set' do
        let(:collection) { create :collection }

        describe 'an un-associated Collection' do
          specify 'associates the Storage to the Collection' do
            expect(Storage.find(storage.id).collections).not_to include collection
            xhr :patch, :update, id: storage.id, sub_action: :associate, collection_id: collection.id
            expect(Storage.find(storage.id).collections).to include collection
          end
        end

        describe 'an already associated Collection' do
          specify 'raises error' do
            storage.collections << collection
            expect(Storage.find(storage.id).collections).to include collection
            expect {
              xhr :patch, :update, id: storage.id, sub_action: :associate, collection_id: collection.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end
    end

    describe 'with :sub_action => :deassociate' do
      describe 'and :collection_id' do
        let(:collection) { create :collection }

        describe 'set to an associated Collection' do
          specify 'removes this association' do
            storage.collections << collection
            expect(Storage.find(storage.id).collections).to include collection
            xhr :patch, :update, id: storage.id, sub_action: :deassociate, collection_id: collection.id
            expect(Storage.find(storage.id).collections).not_to include collection
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
