require 'rails_helper'

describe ApplicationHelper, type: :helper do
  shared_examples 'link_to_entity_helpers' do |action|
    let(:storage) { create :storage }
    let(:html_link) { send("link_to_#{action}_entity", storage) }

    specify 'uses Bootstrap\'s tooltip interface' do
      expect(html_link).to match /data-toggle="tooltip"/
    end
  end

  describe '#link_to_show_entity' do
    describe 'creates a link-button' do
      include_examples 'link_to_entity_helpers', 'show'

      specify 'to show the given entity' do
        expect(html_link).to match /Show Details/
        expect(html_link).to match storage_path(storage)
      end

      specify 'displays a search icon' do
        expect(html_link).to match /<i class="fa fa-fw fa-search"><\/i>/
      end
    end
  end

  describe '#link_to_edit_entity' do
    describe 'creates a link-button' do
      include_examples 'link_to_entity_helpers', 'edit'

      specify 'to edit the given entity' do
        expect(html_link).to match /Edit Storage/
        expect(html_link).to match edit_storage_path(storage)
      end

      specify 'displays a pencil icon' do
        expect(html_link).to match /<i class="fa fa-fw fa-pencil"><\/i>/
      end
    end
  end

  describe '#link_to_destroy_entity' do
    describe 'creates a link-button' do
      include_examples 'link_to_entity_helpers', 'destroy'

      specify 'to delete the given entity' do
        expect(html_link).to match /Delete Storage/
        expect(html_link).to match storage_path(storage)
      end

      specify 'displays a trash icon' do
        expect(html_link).to match /<i class="fa fa-fw fa-trash"><\/i>/
      end
    end
  end
end
