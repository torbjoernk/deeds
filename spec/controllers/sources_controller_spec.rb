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

    describe 'filtered by associated Archive', use_db: true do
      let(:archive) do
        archive = create :archive
        archive.sources << source
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
      let(:archive) { create :archive }

      it 'assigns @free_sources' do
        xhr :get, :edit, id: source.id, sub_action: :refresh_nested
        expect(assigns :free_archives).to include archive
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
      describe 'and :archive_id set' do
        let(:archive) { create :archive }

        describe 'an un-associated Archive' do
          specify 'associates the Source to the Archive' do
            expect(Source.find(source.id).archives).not_to include archive
            xhr :patch, :update, id: source.id, sub_action: :associate, archive_id: archive.id
            expect(Source.find(source.id).archives).to include archive
          end
        end

        describe 'an already associated Archive' do
          specify 'raises error' do
            source.archives << archive
            expect(Source.find(source.id).archives).to include archive
            expect {
              xhr :patch, :update, id: source.id, sub_action: :associate, archive_id: archive.id
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
            source.archives << archive
            expect(Source.find(source.id).archives).to include archive
            xhr :patch, :update, id: source.id, sub_action: :deassociate, archive_id: archive.id
            expect(Source.find(source.id).archives).not_to include archive
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
