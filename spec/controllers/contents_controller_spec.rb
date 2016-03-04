require 'rails_helper'

describe ContentsController, type: :controller do
  shared_context 'Content exists' do
    let(:content) { create :content }
  end

  describe 'GET #index', use_db: true do
    include_context 'Content exists'

    it 'assigns @contents' do
      get :index
      expect(assigns :contents).to include content
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
    include_context 'Content exists'

    it 'assigns @content' do
      xhr :get, :show, id: content.id
      expect(assigns :content).to eq content
    end

    it 'renders the show template' do
      xhr :get, :show, id: content.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'Content exists'

    describe 'without additional parameters' do
      it 'assigns @content' do
        xhr :get, :edit, id: content.id
        expect(assigns :content).to eq content
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: content.id
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new Content from arguments', use_db: true do
      content = build :content
      xhr :post, :create, content: { content: content.content, language: content.language }
      expect(assigns :content).to be_a Content
      expect(flash[:success]).to match /Created new content/
      expect(response).to redirect_to contents_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'Content exists'

    describe 'without additional parameters' do
      it 'updates specific Content from arguments' do
        content.content = 'Something different'
        xhr :patch, :update, id: content.id, content: { content: content.content }
        expect(flash[:success]).to match /Updated content/
        expect(response).to redirect_to contents_path
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'Content exists'

    it 'deletes a specific Content' do
      xhr :delete, :destroy, id: content.id
      expect(flash[:success]).to match /Deleted Content/
      expect(response).to redirect_to contents_path
    end
  end
end
