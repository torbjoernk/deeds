require 'rails_helper'

describe SourcesController, type: :controller do
  shared_context 'Source exists' do
    let(:source) { create :source }
  end

  describe 'GET #index', use_db: true do
    include_context 'Source exists'

    it 'assigns @sources' do
      get :index
      expect(assigns :sources).to include source
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    describe 'filtered by associated Collection', use_db: true do
      let(:collection) do
        collection = create :collection
        collection.sources << source
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
        expect(assigns :sources).to include source
      end
    end

    describe 'filtered by associated Deed', use_db: true do
      let(:deed) do
        deed = create :deed
        deed.sources << source
        deed.save!
        deed
      end

      specify 'renders the index template' do
        get :index, deed_id: deed.id
        expect(response).to render_template :index
      end

      specify 'assigns @storages and @deed' do
        get :index, deed_id: deed.id
        expect(assigns :deed).to eq deed
        expect(assigns :sources).to include source
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
    include_context 'Source exists'

    it 'assigns @source' do
      xhr :get, :show, id: source.id
      expect(assigns :source).to eq source
    end

    it 'renders the show template' do
      xhr :get, :show, id: source.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Source exists'

    describe 'without additional parameters' do
      it 'assigns @source' do
        xhr :get, :edit, id: source.id
        expect(assigns :source).to eq source
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: source.id
        expect(response).to render_template :edit
      end
    end

    describe 'with :sub_action => :refresh_nested' do
      let(:collection) { create :collection }

      it 'assigns @free_sources' do
        xhr :get, :edit, id: source.id, sub_action: :refresh_nested
        expect(assigns :unassociated).to include :collections
      end

      it 'renders the form refresh template' do
        xhr :get, :edit, id: source.id, sub_action: :refresh_nested
        expect(response).to render_template 'sources/form/_refresh'
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Source from arguments', use_db: true do
      source = build :source
      xhr :post, :create, source: { title: source.title, source_type: source.source_type, notes: source.notes }
      expect(assigns :source).to be_an Source
      expect(flash[:success]).to match /Created new source/
      expect(response).to redirect_to sources_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Source exists'

    describe 'without additional parameters' do
      it 'updates specific Source from arguments' do
        source.notes = 'Something different'
        xhr :patch, :update, id: source.id, source: { title: source.title, notes: source.notes }
        expect(flash[:success]).to match /Updated source/
        expect(response).to redirect_to sources_path
      end
    end

    describe 'with :sub_action => :associate' do
      describe 'and :collection_id set' do
        let(:collection) { create :collection }

        describe 'an un-associated Collection' do
          specify 'associates the Source to the Collection' do
            expect(Source.find(source.id).collections).not_to include collection
            xhr :patch, :update, id: source.id, sub_action: :associate, collection_id: collection.id
            expect(Source.find(source.id).collections).to include collection
          end
        end

        describe 'an already associated Collection' do
          specify 'raises error' do
            source.collections << collection
            expect(Source.find(source.id).collections).to include collection
            expect {
              xhr :patch, :update, id: source.id, sub_action: :associate, collection_id: collection.id
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
            source.collections << collection
            expect(Source.find(source.id).collections).to include collection
            xhr :patch, :update, id: source.id, sub_action: :deassociate, collection_id: collection.id
            expect(Source.find(source.id).collections).not_to include collection
          end
        end
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Source exists'

    it 'deletes a specific Source' do
      xhr :delete, :destroy, id: source.id
      expect(flash[:success]).to match /Deleted Source/
      expect(response).to redirect_to sources_path
    end
  end
end
