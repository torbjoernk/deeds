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

    it 'assigns @source' do
      xhr :get, :edit, id: source.id
      expect(assigns :source).to eq source
    end

    it 'renders the edit template' do
      xhr :get, :edit, id: source.id
      expect(response).to render_template :edit
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

    it 'updates specific Source from arguments' do
      source.notes = 'Something different'
      xhr :patch, :update, id: source.id, source: { title: source.title, notes: source.notes }
      expect(flash[:success]).to match /Updated source/
      expect(response).to redirect_to sources_path
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Source exists'

    it 'deletes a specific Source' do
      xhr :delete, :destroy, id: source.id
      expect(flash[:success]).to match /Deleted source/
      expect(response).to redirect_to sources_path
    end
  end
end
