require 'rails_helper'

describe 'routing for Collections', type: :routing do
  let(:collection) { create :collection }
  let(:storage) { create :storage }

  describe 'GET' do
    specify '/collections routes to collections#index' do
      expect(get: '/collections').to route_to 'collections#index'
    end

    specify '/collections/:id routes to collections#show', use_db: true do
      expect(get: "/collections/#{collection.id}/", format: 'js').
          to route_to 'collections#show', id: collection.id.to_s
    end

    specify '/collections/:id/edit routes to collections#edit', use_db: true do
      expect(get: "/collections/#{collection.id}/edit", format: 'js').
          to route_to 'collections#edit', id: collection.id.to_s
    end
  end

  describe 'POST' do
    specify '/collections routes to collections#create' do
      expect(post: '/collections').to route_to 'collections#create'
    end
  end

  describe 'PATCH' do
    specify '/collections/:id routes to collections#update', use_db: true do
      expect(patch: "/collections/#{collection.id}", format: 'js').
          to route_to 'collections#update', id: collection.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/collections/:id routes to collections#destroy', use_db: true do
      expect(delete: "/collections/#{collection.id}", format: 'js').
          to route_to 'collections#destroy', id: collection.id.to_s
    end
  end
end
