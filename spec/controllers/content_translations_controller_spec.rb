require 'rails_helper'

describe ContentTranslationsController, type: :controller do
  shared_context 'ContentTranslation exists' do
    let(:content_translation) { create :content_translation }
  end

  describe 'GET #index', use_db: true do
    include_context 'ContentTranslation exists'

    it 'assigns @content_translations' do
      get :index
      expect(assigns :content_translations).to include content_translation
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
    include_context 'ContentTranslation exists'

    it 'assigns @content_translation' do
      xhr :get, :show, id: content_translation.id
      expect(assigns :content_translation).to eq content_translation
    end

    it 'renders the show template' do
      xhr :get, :show, id: content_translation.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit via XHR', use_db: true do
    include_context 'ContentTranslation exists'

    describe 'without additional parameters' do
      it 'assigns @content_translation' do
        xhr :get, :edit, id: content_translation.id
        expect(assigns :content_translation).to eq content_translation
      end

      it 'renders the edit template' do
        xhr :get, :edit, id: content_translation.id
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create via XHR' do
    it 'creates a new ContentTranslation from arguments', use_db: true do
      content_translation = build :content_translation
      xhr :post, :create, content_translation: { translation: content_translation.translation,
                                                 language: content_translation.language }
      expect(assigns :content_translation).to be_a ContentTranslation
      expect(flash[:success]).to match /Created new content translation/
      expect(response).to redirect_to content_translations_path
    end
  end

  describe 'PATCH #update via XHR', use_db: true do
    include_context 'ContentTranslation exists'

    describe 'without additional parameters' do
      it 'updates specific ContentTranslation from arguments' do
        content_translation.translation = 'Something different'
        xhr :patch, :update, id: content_translation.id,
            content_translation: { translation: content_translation.translation }
        expect(flash[:success]).to match /Updated content translation/
        expect(response).to redirect_to content_translations_path
      end
    end
  end

  describe 'DELETE #destroy via XHR', use_db: true do
    include_context 'ContentTranslation exists'

    it 'deletes a specific ContentTranslation' do
      xhr :delete, :destroy, id: content_translation.id
      expect(flash[:success]).to match /Deleted Content translation/
      expect(response).to redirect_to content_translations_path
    end
  end
end
