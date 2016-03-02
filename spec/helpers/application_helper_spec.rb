require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#icon_for' do
    describe 'for classes implementing the IconicModel concern' do
      class IconicTestClass
        include IconicModel
        ICON = 'test'
      end

      specify 'returns FontAwesome icon tag' do
        expect(icon_for(IconicTestClass)).to eq '<i class="fa fa-fw fa-test"></i>'
      end
    end

    describe 'for classes NOT implementing the IconicModel concern' do
      class TestClass
      end

      specify 'returns nothing' do
        expect(Rails.logger).to receive(:warn).with(/No icon defined for model/)
        expect(icon_for(TestClass)).to eq ''
      end
    end
  end

  describe '#model_name_with_icon' do
    describe 'for ActiveRecord::Base models' do
      describe 'that implement the IconicModel concern' do
        class IconicTestModel < ActiveRecord::Base
          include IconicModel
          ICON = 'test'
        end

        specify 'returns singular humanized name by default' do
          expect(model_name_with_icon(IconicTestModel)).
              to eq '<i class="fa fa-fw fa-test"></i> Iconic test model'
        end

        specify 'returns pluralized human name with :plural specifier' do
          expect(model_name_with_icon(IconicTestModel, :plural)).
              to eq '<i class="fa fa-fw fa-test"></i> Iconic test models'
        end
      end

      describe 'that do NOT implement the IconicModel concern' do
        class TestModel < ActiveRecord::Base
        end

        specify 'returns singular humanized name by default' do
          expect(model_name_with_icon(TestModel)).to eq 'Test model'
        end

        specify 'returns pluralized human name with :plural specifier' do
          expect(model_name_with_icon(TestModel, :plural)).to eq 'Test models'
        end
      end

      specify 'raises error for invalid quantity specifier' do
        expect {
          model_name_with_icon IconicTestModel, :not_a_quantity
        }.to raise_error StandardError
      end
    end

    describe 'for other classes' do
      specify 'raises an error' do
        expect {
          model_name_from_record_or_class TestClass
        }.to raise_error StandardError
      end
    end
  end

  shared_examples 'link_to_entity_helpers' do |action|
    let(:storage) { create :storage }
    let(:html_link) { send("link_to_#{action}_entity", storage) }

    specify 'uses Bootstrap\'s tooltip interface' do
      expect(html_link).to match /data-toggle="tooltip"/
    end
  end

  describe '#link_to_show_entity' do
    describe 'creates a link-button', use_db: true do
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
    describe 'creates a link-button', use_db: true do
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
    describe 'creates a link-button', use_db: true do
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
