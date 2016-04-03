require 'rails_helper'

describe CollectionsController, type: :controller do
  shared_context 'Collection exists' do
    let(:collection) { create :collection }
  end

  describe 'GET #index', use_db: true do
    include_context 'Collection exists'

    it 'assigns @collections' do
      get :index
      expect(assigns :collections).to include collection
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    describe 'filtered by associated Storage', use_db: true do
      let(:storage) do
        storage = create :storage
        collection.storages << storage
        collection.save!
        storage
      end

      specify 'renders the index template' do
        get :index, storage_id: storage.id
        expect(response).to render_template :index
      end

      specify 'assigns @collections and @storage' do
        get :index, storage_id: storage.id
        expect(assigns :storage).to eq storage
        expect(assigns :collections).to include collection
      end
    end

    describe 'filtered by associated Source', use_db: true do
      let(:source) do
        source = create :source
        collection.sources << source
        collection.save!
        source
      end

      specify 'renders the index template' do
        get :index, source_id: source.id
        expect(response).to render_template :index
      end

      specify 'assigns @collections and @source' do
        get :index, source_id: source.id
        expect(assigns :source).to eq source
        expect(assigns :collections).to include collection
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
    include_context 'Collection exists'

    it 'assigns @collection' do
      xhr :get, :show, id: collection.id
      expect(assigns :collection).to eq collection
    end

    it 'renders the show template' do
      xhr :get, :show, id: collection.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Collection exists'

    describe 'without additional parameters' do
      it 'assigns @collection' do
        xhr :get, :edit, id: collection.id
        expect(assigns :collection).to eq collection
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: collection.id
        expect(response).to render_template :edit
      end
    end

    describe 'with :sub_action => :refresh_nested' do
      let(:source) { create :source }
      let(:storage) { create :storage }

      it 'assigns @free_sources' do
        xhr :get, :edit, id: collection.id, sub_action: :refresh_nested
        expect(assigns :free_sources).to include source
      end

      it 'assigns @free_storages' do
        xhr :get, :edit, id: collection.id, sub_action: :refresh_nested
        expect(assigns :free_storages).to include storage
      end

      it 'renders the form refresh template' do
        xhr :get, :edit, id: collection.id, sub_action: :refresh_nested
        expect(response).to render_template 'collections/form/_refresh'
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Collection from arguments', use_db: true do
      collection = build :collection
      xhr :post, :create, collection: {title: collection.title, notes: collection.notes }
      expect(assigns :collection).to be_an Collection
      expect(flash[:success]).to match /Created new collection/
      expect(response).to redirect_to collections_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Collection exists'

    describe 'without additional parameters' do
      it 'updates specific Collection from arguments' do
        collection.notes = 'Something different'
        xhr :patch, :update, id: collection.id, collection: {title: collection.title, notes: collection.notes }
        expect(flash[:success]).to match /Updated collection/
        expect(response).to redirect_to collections_path
      end
    end

    describe 'with :sub_action => :associate' do
      describe 'and :source_id set' do
        let(:source) { create :source }

        describe 'to an un-associated Source' do
          it 'associates the Source to the Collection' do
            expect(collection.sources).not_to include source
            xhr :patch, :update, id: collection.id, sub_action: :associate, source_id: source.id
            expect(Collection.find_by(id: collection.id).sources).to include source
          end
        end

        describe 'to an already associated Source' do
          it 'raises error' do
            collection.sources << source
            expect(Collection.find(collection.id).sources).to include source
            expect {
              xhr :patch, :update, id: collection.id, sub_action: :associate, source_id: source.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end

      describe 'and :storage_id set' do
        let(:storage) { create :storage }

        describe 'to an un-associated Storage' do
          it 'associates the Storage to the Collection' do
            expect(collection.storages).not_to include storage
            xhr :patch, :update, id: collection.id, sub_action: :associate, storage_id: storage.id
            expect(Collection.find(collection.id).storages).to include storage
          end
        end

        describe 'to an already associated Storage' do
          it 'raises error' do
            collection.storages << storage
            expect(Collection.find(collection.id).storages).to include storage
            expect {
              xhr :patch, :update, id: collection.id, sub_action: :associate, storage_id: storage.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end
    end

    describe 'with :sub_action => :deassociate' do
      describe 'and :source_id set to an associated Source' do
        let(:source) { create :source }

        specify 'removes this association' do
          collection.sources << source
          expect(Collection.find(collection.id).sources).to include source
          xhr :patch, :update, id: collection.id, sub_action: :deassociate, source_id: source.id
          expect(Collection.find(collection.id).sources).not_to include source
        end
      end

      describe 'and :storage_id set to an associated Storage' do
        let(:storage) { create :storage }

        specify 'removes this association' do
          collection.storages << storage
          expect(Collection.find(collection.id).storages).to include storage
          xhr :patch, :update, id: collection.id, sub_action: :deassociate, storage_id: storage.id
          expect(Collection.find(collection.id).storages).not_to include storage
        end
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Collection exists'

    it 'deletes a specific Collection' do
      xhr :delete, :destroy, id: collection.id
      expect(flash[:success]).to match /Deleted Collection/
      expect(response).to redirect_to collections_path
    end
  end
end
