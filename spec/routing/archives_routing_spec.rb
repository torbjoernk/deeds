require 'rails_helper'

describe 'routing for Archives', type: :routing do
  let(:archive) { create :archive }
  let(:storage) { create :storage }

  describe 'GET' do
    specify '/archives routes to archives#index' do
      expect(get: '/archives').to route_to 'archives#index'
    end

    specify '/archives/:id routes to archives#show', use_db: true do
      expect(get: "/archives/#{archive.id}/", format: 'js').
          to route_to 'archives#show', id: archive.id.to_s
    end

    specify '/archives/:id/edit routes to archives#edit', use_db: true do
      expect(get: "/archives/#{archive.id}/edit", format: 'js').
          to route_to 'archives#edit', id: archive.id.to_s
    end
  end

  describe 'POST' do
    specify '/archives routes to archives#create' do
      expect(post: '/archives').to route_to 'archives#create'
    end
  end

  describe 'PATCH' do
    specify '/archives/:id routes to archives#update', use_db: true do
      expect(patch: "/archives/#{archive.id}", format: 'js').
          to route_to 'archives#update', id: archive.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/archives/:id routes to archives#destroy', use_db: true do
      expect(delete: "/archives/#{archive.id}", format: 'js').
          to route_to 'archives#destroy', id: archive.id.to_s
    end
  end
end
