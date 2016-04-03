require 'rails_helper'

describe DocumentsController, type: :controller do
  shared_context 'Document exists' do
    let(:document) { create :document }
  end

  describe 'GET #index', use_db: true do
    include_context 'Document exists'

    it 'assigns @documents' do
      get :index
      expect(assigns :documents).to include document
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    describe 'filtered by associated Collection', use_db: true do
      let(:collection) do
        collection = create :collection
        collection.documents << document
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
        expect(assigns :documents).to include document
      end
    end

    describe 'filtered by associated Deed', use_db: true do
      let(:deed) do
        deed = create :deed
        deed.documents << document
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
        expect(assigns :documents).to include document
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
    include_context 'Document exists'

    it 'assigns @document' do
      xhr :get, :show, id: document.id
      expect(assigns :document).to eq document
    end

    it 'renders the show template' do
      xhr :get, :show, id: document.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Document exists'

    describe 'without additional parameters' do
      it 'assigns @document' do
        xhr :get, :edit, id: document.id
        expect(assigns :document).to eq document
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: document.id
        expect(response).to render_template :edit
      end
    end

    describe 'with :sub_action => :refresh_nested' do
      let(:collection) { create :collection }

      it 'assigns @free_documents' do
        xhr :get, :edit, id: document.id, sub_action: :refresh_nested
        expect(assigns :unassociated).to include :collections
      end

      it 'renders the form refresh template' do
        xhr :get, :edit, id: document.id, sub_action: :refresh_nested
        expect(response).to render_template 'documents/form/_refresh'
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Document from arguments', use_db: true do
      document = build :document
      xhr :post, :create, document: {title: document.title, document_type: document.document_type, notes: document.notes }
      expect(assigns :document).to be_a Document
      expect(flash[:success]).to match /Created new document/
      expect(response).to redirect_to documents_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Document exists'

    describe 'without additional parameters' do
      it 'updates specific Document from arguments' do
        document.notes = 'Something different'
        xhr :patch, :update, id: document.id, document: {title: document.title, notes: document.notes }
        expect(flash[:success]).to match /Updated document/
        expect(response).to redirect_to documents_path
      end
    end

    describe 'with :sub_action => :associate' do
      describe 'and :collection_id set' do
        let(:collection) { create :collection }

        describe 'an un-associated Collection' do
          specify 'associates the Document to the Collection' do
            expect(Document.find_by(id: document.id).collections).not_to include collection
            xhr :patch, :update, id: document.id, sub_action: :associate, collection_id: collection.id
            expect(Document.find_by(id: document.id).collections).to include collection
          end
        end

        describe 'an already associated Collection' do
          specify 'raises error' do
            document.collections << collection
            expect(Document.find_by(id: document.id).collections).to include collection
            expect {
              xhr :patch, :update, id: document.id, sub_action: :associate, collection_id: collection.id
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
            document.collections << collection
            expect(Document.find_by(id: document.id).collections).to include collection
            xhr :patch, :update, id: document.id, sub_action: :deassociate, collection_id: collection.id
            expect(Document.find_by(id: document.id).collections).not_to include collection
          end
        end
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Document exists'

    it 'deletes a specific Document' do
      xhr :delete, :destroy, id: document.id
      expect(flash[:success]).to match /Deleted Document/
      expect(response).to redirect_to documents_path
    end
  end
end
