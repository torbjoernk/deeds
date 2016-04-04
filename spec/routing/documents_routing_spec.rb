require 'rails_helper'

describe 'routing for Documents', type: :routing do
  let(:document) { create :document }

  describe 'GET' do
    specify '/documents routes to documents#index' do
      expect(get: '/documents').to route_to 'documents#index'
    end

    specify '/documents/new routes to documents#new' do
      expect(get: '/documents/new').to route_to 'documents#new'
    end

    specify '/documents/:id routes to documents#show', use_db: true do
      expect(get: "/documents/#{document.id}/", format: 'js').
          to route_to 'documents#show', id: document.id.to_s
    end

    specify '/documents/:id/edit routes to documents#edit', use_db: true do
      expect(get: "/documents/#{document.id}/edit", format: 'js').
          to route_to 'documents#edit', id: document.id.to_s
    end
  end

  describe 'POST' do
    specify '/documents routes to documents#create' do
      expect(post: '/documents').to route_to 'documents#create'
    end
  end

  describe 'PATCH' do
    specify '/documents/:id routes to documents#update', use_db: true do
      expect(patch: "/documents/#{document.id}", format: 'js').
          to route_to 'documents#update', id: document.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/documents/:id routes to documents#destroy', use_db: true do
      expect(delete: "/documents/#{document.id}", format: 'js').
          to route_to 'documents#destroy', id: document.id.to_s
    end
  end
end
