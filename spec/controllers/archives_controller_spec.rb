require 'rails_helper'

describe ArchivesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @archives' do
      archive = create :archive
      get :index
      expect(assigns :archives).to include archive
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

  describe 'GET #show via XHR' do
    it 'assigns @archive' do
      archive = create :archive
      xhr :get, :show, id: archive.id
      expect(assigns :archive).to eq archive
    end

    it 'renders the show template' do
      archive = create :archive
      xhr :get, :show, id: archive.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR' do
    it 'assigns @archive' do
      archive = create :archive
      xhr :get, :edit, id: archive.id
      expect(assigns :archive).to eq archive
    end

    it 'renders the edit template' do
      archive = create :archive
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
    it 'updates specific Archive from arguments' do
      archive = create :archive
      archive.notes = 'Something different'
      xhr :patch, :update, id: archive.id, archive: { title: archive.title, notes: archive.notes }
      expect(flash[:success]).to match /Updated archive/
      expect(response).to redirect_to archives_path
    end
  end

  describe 'DELETE #destroy via XHR' do
    it 'deletes a specific Archive' do
      archive = create :archive
      xhr :delete, :destroy, id: archive.id
      expect(flash[:success]).to match /Deleted archive/
      expect(response).to redirect_to archives_path
    end
  end
end
