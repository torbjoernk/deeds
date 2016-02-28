require 'rails_helper'

describe ApplicationHelper, type: :helper do
  before :each do
    @storage = create :storage
  end

  describe '#link_to_show_entity' do
    describe 'creates a link-button' do
      before :each do
        @html_link = link_to_show_entity @storage
      end

      specify 'to show the given entity' do
        expect(@html_link).to match /Show Details/
        expect(@html_link).to match storage_path(@storage)
      end

      specify 'displays a search icon' do
        expect(@html_link).to match /<i class="fa fa-fw fa-search"><\/i>/
      end

      specify 'uses Bootstrap\'s tooltip interface' do
        expect(@html_link).to match /data-toggle="tooltip"/
      end
    end
  end

  describe '#link_to_edit_entity' do
    describe 'creates a link-button' do
      before :each do
        @html_link = link_to_edit_entity @storage
      end

      specify 'to edit the given entity' do
        expect(@html_link).to match /Edit Storage/
        expect(@html_link).to match edit_storage_path(@storage)
      end

      specify 'displays a pencil icon' do
        expect(@html_link).to match /<i class="fa fa-fw fa-pencil"><\/i>/
      end

      specify 'uses Bootstrap\'s tooltip interface' do
        expect(@html_link).to match /data-toggle="tooltip"/
      end
    end
  end

  describe '#link_to_destroy_entity' do
    describe 'creates a link-button' do
      before :each do
        @html_link = link_to_destroy_entity @storage
      end

      specify 'to delete the given entity' do
        expect(@html_link).to match /Delete Storage/
        expect(@html_link).to match storage_path(@storage)
      end

      specify 'displays a trash icon' do
        expect(@html_link).to match /<i class="fa fa-fw fa-trash"><\/i>/
      end

      specify 'uses Bootstrap\'s tooltip interface' do
        expect(@html_link).to match /data-toggle="tooltip"/
      end
    end
  end
end
