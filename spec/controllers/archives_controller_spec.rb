require 'rails_helper'

describe ArchivesController, type: :controller do
  shared_context 'Archive exists' do
    let(:archive) { create :archive }
  end

  describe 'GET #index', use_db: true do
    include_context 'Archive exists'

    it 'assigns @archives' do
      get :index
      expect(assigns :archives).to include archive
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    describe 'filtered by associated Storage', use_db: true do
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

    describe 'filtered by associated Source', use_db: true do
      let(:source) do
        source = create :source
        archive.sources << source
        archive.save!
        source
      end

      specify 'renders the index template' do
        get :index, source_id: source.id
        expect(response).to render_template :index
      end

      specify 'assigns @archives and @source' do
        get :index, source_id: source.id
        expect(assigns :source).to eq source
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

  describe 'GET #show via XHR', use_db: true do
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

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Archive exists'

    describe 'without additional parameters' do
      it 'assigns @archive' do
        xhr :get, :edit, id: archive.id
        expect(assigns :archive).to eq archive
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: archive.id
        expect(response).to render_template :edit
      end
    end

    describe 'with :sub_action => :refresh_nested' do
      let(:source) { create :source }
      let(:storage) { create :storage }

      it 'assigns @free_sources' do
        xhr :get, :edit, id: archive.id, sub_action: :refresh_nested
        expect(assigns :free_sources).to include source
      end

      it 'assigns @free_storages' do
        xhr :get, :edit, id: archive.id, sub_action: :refresh_nested
        expect(assigns :free_storages).to include storage
      end

      it 'renders the form refresh template' do
        xhr :get, :edit, id: archive.id, sub_action: :refresh_nested
        expect(response).to render_template 'archives/form/_refresh'
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Archive from arguments', use_db: true do
      archive = build :archive
      xhr :post, :create, archive: { title: archive.title, notes: archive.notes }
      expect(assigns :archive).to be_an Archive
      expect(flash[:success]).to match /Created new archive/
      expect(response).to redirect_to archives_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Archive exists'

    describe 'without additional parameters' do
      it 'updates specific Archive from arguments' do
        archive.notes = 'Something different'
        xhr :patch, :update, id: archive.id, archive: { title: archive.title, notes: archive.notes }
        expect(flash[:success]).to match /Updated archive/
        expect(response).to redirect_to archives_path
      end
    end

    describe 'with :sub_action => :associate' do
      describe 'and :source_id set' do
        let(:source) { create :source }

        describe 'to an un-associated Source' do
          it 'associates the Source to the Archive' do
            expect(archive.sources).not_to include source
            xhr :patch, :update, id: archive.id, sub_action: :associate, source_id: source.id
            expect(Archive.find(archive.id).sources).to include source
          end
        end

        describe 'to an already associated Source' do
          it 'raises error' do
            archive.sources << source
            expect(Archive.find(archive.id).sources).to include source
            expect {
              xhr :patch, :update, id: archive.id, sub_action: :associate, source_id: source.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end

      describe 'and :storage_id set' do
        let(:storage) { create :storage }

        describe 'to an un-associated Storage' do
          it 'associates the Storage to the Archive' do
            expect(archive.storages).not_to include storage
            xhr :patch, :update, id: archive.id, sub_action: :associate, storage_id: storage.id
            expect(Archive.find(archive.id).storages).to include storage
          end
        end

        describe 'to an already associated Storage' do
          it 'raises error' do
            archive.storages << storage
            expect(Archive.find(archive.id).storages).to include storage
            expect {
              xhr :patch, :update, id: archive.id, sub_action: :associate, storage_id: storage.id
            }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end
    end

    describe 'with :sub_action => :deassociate' do
      describe 'and :source_id set to an associated Source' do
        let(:source) { create :source }

        specify 'removes this association' do
          archive.sources << source
          expect(Archive.find(archive.id).sources).to include source
          xhr :patch, :update, id: archive.id, sub_action: :deassociate, source_id: source.id
          expect(Archive.find(archive.id).sources).not_to include source
        end
      end

      describe 'and :storage_id set to an associated Storage' do
        let(:storage) { create :storage }

        specify 'removes this association' do
          archive.storages << storage
          expect(Archive.find(archive.id).storages).to include storage
          xhr :patch, :update, id: archive.id, sub_action: :deassociate, storage_id: storage.id
          expect(Archive.find(archive.id).storages).not_to include storage
        end
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Archive exists'

    it 'deletes a specific Archive' do
      xhr :delete, :destroy, id: archive.id
      expect(flash[:success]).to match /Deleted Archive/
      expect(response).to redirect_to archives_path
    end
  end
end
