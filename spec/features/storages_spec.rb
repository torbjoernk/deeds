require 'rails_helper'

feature 'On the Storage Page', type: :feature do
  before :each do
    visit storages_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Storage" button', js: true do
      let(:new_storage) { build :storage }

      before :each do
        find(:css, '#btn-new-storage').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector 'div#form-modal', visible: true
        end

        context 'enters the new Storage\'s title and type' do
          before :each do
            within 'div#form-modal' do
              fill_in Storage.human_attribute_name(:title), with: new_storage.title
            end
          end

          context 'and clicks on the "Create Storage" button', with_db: true do
            before :each do
              click_on 'Create Storage'
            end

            scenario 'then a new Storage with given title and type should be created' do
              within 'div#storages-table' do
                expect(page).to have_text new_storage.title
              end
            end
          end
        end
      end
    end
  end

  context 'given a Storage exists', with_db: true do
    before :each do
      @storage = create :storage
      visit storages_path
    end

    scenario 'then the User should see a table with Storages' do
      expect(page).to have_selector 'div#storages-table'
    end

    context 'then the User should see the breadcrumbs' do
      scenario 'with "Home"' do
        expect(page).to have_breadcrumb 'Home'
      end

      scenario "with \"#{Storage.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Storage.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Storage', js: true do
        before :each do
          expect(@storage.persisted?).to be true
          within 'div#storages-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-storage-show-#{@storage.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector 'div#show-modal', visible: true
          end

          scenario 'the User should see the Storage\'s title' do
            within 'div#show-modal' do
              expect(page).to have_text @storage.title
            end
          end

          scenario 'the User should see the Storage\'s notes' do
            within 'div#show-modal' do
              expect(page).to have_text @storage.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Storage', js: true do
        before :each do
          expect(@storage.persisted?).to be true
          within 'div#storages-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-storage-edit-#{@storage.id}").click
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector 'div#form-modal', visible: true
          end

          context 'changes the Storage\'s title' do
            let(:new_storage) do
              s = build :storage, title: Faker::Name.title
              expect(s).to be_valid
              s
            end

            before :each do
              within 'div#form-modal' do
                fill_in Storage.human_attribute_name(:title), with: new_storage.title
              end
            end

            context 'and clicks on the "Update Storage" button' do
              before :each do
                within 'div#form-modal' do
                  click_on 'Update Storage'
                end
              end

              scenario 'then the Storage\'s title should be changed' do
                within "div#storage-#{@storage.id}.entity.row" do
                  expect(page).to have_text new_storage.title
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Storage', js: true do
        before :each do
          expect(@storage.persisted?).to be true
          within 'div#storages-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              find(:css, "#btn-storage-delete-#{@storage.id}").click
            end
          end

          scenario 'then the Storage gets deleted' do
            expect(page).not_to have_selector "div#storage-#{@storage.id}.entity.row"
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              find(:css, "#btn-storage-delete-#{@storage.id}").click
            end
          end

          scenario 'then the Storage is kept' do
            expect(page).to have_selector "div#storage-#{@storage.id}.entity.row"
          end
        end
      end
    end

    context 'and is associated to an Collection', with_db: true do
      before :each do
        collection = create :collection
        @storage.collections << collection
        @storage.save!

        visit storages_path
      end

      context 'when the User clicks on the "Edit" button of the first Storage', js: true do
        before :each do
          find(:css, "#btn-storage-edit-#{@storage.id}").click
          expect(page).to have_selector 'div#form-modal', visible: true

          within 'div#form-modal' do
            within 'ul#associate-collections' do
              expect(page).to have_text collection.title
            end
          end
        end

        scenario 'then no further Collections should be associatable' do
          within 'ul#associate-collections' do
            expect(page).to have_text 'no unassociated Collections'
          end
        end

        feature 'and the User clicks on the "de-associate" button', skip: WITHOUT_AJAX do
          before :each do
            within 'div#form-modal' do
              find(:css, "#btn-deassoc-collection-#{collection.id}").click
            end
          end

          scenario 'then the association is removed' do
            within 'div#form-modal' do
              expect(page).not_to have_text collection.title
            end
            expect(Storage.find(@storage.id).collections).not_to include collection
          end
        end
      end
    end

    context 'and an Collection exists', with_db: true do
      before :each do
        collection = create :collection
      end

      context 'when the User clicks on the "Edit" button of the first Storage', js: true do
        before :each do
          find(:css, "#btn-storage-edit-#{@storage.id}").click
          expect(page).to have_selector 'div#form-modal', visible: true
        end

        scenario 'then further Collections should be associatable' do
          within 'ul#associate-collections' do
            expect(page).not_to have_text 'no unassociated Collections'
          end
        end

        context 'and the User enters the Collection\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in 'assoc-collection-input', with: collection.title
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within 'div#form-modal' do
                find(:css, '#btn-associate-selected-collection').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Collection is associated with the Storage' do
              within 'div#form-modal' do
                expect(page).to have_text collection.title
                expect(page).to have_text 'no unassociated Collections'
              end
              expect(Storage.find(@storage.id).collections).to include collection
            end
          end
        end
      end
    end
  end
end
