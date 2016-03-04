require 'rails_helper'

describe 'routing for Contents', type: :routing do
  let(:content) { create :content }

  describe 'GET' do
    specify '/contents routes to contents#index' do
      expect(get: '/contents').to route_to 'contents#index'
    end

    specify '/contents/:id routes to contents#show', use_db: true do
      expect(get: "/contents/#{content.id}/", format: 'js').
          to route_to 'contents#show', id: content.id.to_s
    end

    specify '/contents/:id/edit routes to contents#edit', use_db: true do
      expect(get: "/contents/#{content.id}/edit", format: 'js').
          to route_to 'contents#edit', id: content.id.to_s
    end
  end

  describe 'POST' do
    specify '/contents routes to contents#create' do
      expect(post: '/contents').to route_to 'contents#create'
    end
  end

  describe 'PATCH' do
    specify '/contents/:id routes to contents#update', use_db: true do
      expect(patch: "/contents/#{content.id}", format: 'js').
          to route_to 'contents#update', id: content.id.to_s
    end
  end

  describe 'DELETE' do
    specify '/contents/:id routes to contents#destroy', use_db: true do
      expect(delete: "/contents/#{content.id}", format: 'js').
          to route_to 'contents#destroy', id: content.id.to_s
    end
  end
end
