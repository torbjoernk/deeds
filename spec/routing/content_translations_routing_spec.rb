require 'rails_helper'

describe 'routing for ContentTranslations', type: :routing do
  let(:content_translation) { create :content_translation }

  describe 'GET' do
    specify '/content_translations routes to content_translations#index' do
      expect(get: '/content_translations').to route_to 'content_translations#index'
    end

    specify '/content_translations/:id routes to content_translations#show', use_db: true do
      expect(get: "/content_translations/#{content_translation.id}/", format: 'js').
          to route_to 'content_translations#show', id: content_translation.id.to_s
    end

    specify '/content_translations/:id/edit routes to content_translations#edit', use_db: true do
      expect(get: "/content_translations/#{content_translation.id}/edit", format: 'js').
          to route_to 'content_translations#edit', id: content_translation.id.to_s
    end
  end

  describe 'POST' do
    specify '/content_translations routes to content_translations#create' do
      expect(post: '/content_translations').to route_to 'content_translations#create'
    end
  end

  describe 'PATCH' do
    specify '/content_translations/:id routes to content_translations#update', use_db: true do
      expect(patch: "/content_translations/#{content_translation.id}", format: 'js').
          to route_to 'content_translations#update', id: content_translation.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/content_translations/:id routes to content_translations#destroy', use_db: true do
      expect(delete: "/content_translations/#{content_translation.id}", format: 'js').
          to route_to 'content_translations#destroy', id: content_translation.id.to_s
    end
  end
end
