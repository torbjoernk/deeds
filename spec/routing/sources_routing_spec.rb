require 'rails_helper'

describe 'routing for Sources', type: :routing do
  let(:source) { create :source }

  describe 'GET' do
    specify '/sources routes to sources#index' do
      expect(get: '/sources').to route_to 'sources#index'
    end

    specify '/sources/:id routes to sources#show', use_db: true do
      expect(get: "/sources/#{source.id}/", format: 'js').
          to route_to 'sources#show', id: source.id.to_s
    end

    specify '/sources/:id/edit routes to sources#edit', use_db: true do
      expect(get: "/sources/#{source.id}/edit", format: 'js').
          to route_to 'sources#edit', id: source.id.to_s
    end
  end

  describe 'POST' do
    specify '/sources routes to sources#create' do
      expect(post: '/sources').to route_to 'sources#create'
    end
  end

  describe 'PATCH' do
    specify '/sources/:id routes to sources#update', use_db: true do
      expect(patch: "/sources/#{source.id}", format: 'js').
          to route_to 'sources#update', id: source.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/sources/:id routes to sources#destroy', use_db: true do
      expect(delete: "/sources/#{source.id}", format: 'js').
          to route_to 'sources#destroy', id: source.id.to_s
    end
  end
end
