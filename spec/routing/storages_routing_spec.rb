require 'rails_helper'

describe 'routing for Storages', type: :routing do
  describe 'GET' do
    specify '/storages routes to storages#index' do
      expect(get: '/storages').to route_to 'storages#index'
    end

    specify '/storages/:id routes to storages#show' do
      storage = create :storage
      expect(get: "/storages/#{storage.id}/", format: 'js').
          to route_to 'storages#show', id: storage.id.to_s
    end

    specify '/storages/:id/archives routes to archive#index' do
      archive = create :archive
      storage = create :storage
      storage.archives << archive
      storage.save!
      expect(get: "/storages/#{storage.id}/archives").
          to route_to 'archives#index', storage_id: storage.id.to_s
    end

    specify '/storages/:id/edit routes to storages#edit' do
      storage = create :storage
      expect(get: "/storages/#{storage.id}/edit", format: 'js').
          to route_to 'storages#edit', id: storage.id.to_s
    end
  end

  describe 'POST' do
    specify '/storages routes to storages#create' do
      expect(post: '/storages').to route_to 'storages#create'
    end
  end

  describe 'PATCH' do
    specify '/storages/:id routes to storages#update' do
      storage = create :storage
      expect(patch: "/storages/#{storage.id}", format: 'js').
          to route_to 'storages#update', id: storage.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/storages/:id routes to storages#destroy' do
      storage = create :storage
      expect(delete: "/storages/#{storage.id}", format: 'js').
          to route_to 'storages#destroy', id: storage.id.to_s
    end
  end
end
