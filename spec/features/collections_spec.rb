require 'rails_helper'

feature 'On the Collection Page', type: :feature do
  before :each do
    visit collections_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Collection" button', js: true do
      let(:new_collection) { build :collection }

      before :each do
        find(:css, '#btn-new-collection').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector '#form-modal', visible: true
        end

        context 'enters the new Collection\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in Collection.human_attribute_name(:title), with: new_collection.title
            end
          end

          context 'and clicks on the "Create Collection" button', with_db: true do
            before :each do
              click_on 'Create Collection'
            end

            scenario 'then a new Collection with given title should be created' do
              within 'div#collections-table' do
                expect(page).to have_text new_collection.title
              end
            end
          end
        end
      end
    end
  end

  context 'given an Collection exists', with_db: true do
    before :each do
      @collection = create :collection
      visit collections_path
    end

    scenario 'then the User should see a table with collections' do
      expect(page).to have_selector 'div#collections-table'
    end

    context 'then the User should see the breadcrumbs' do
      scenario 'with "Home"' do
        expect(page).to have_breadcrumb 'Home'
      end

      scenario "with \"#{Collection.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Collection.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Collection', js: true do
        before :each do
          expect(@collection.persisted?).to be true
          within 'div#collections-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-collection-show-#{@collection.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector '#show-modal', visible: true
          end

          scenario 'the User should see the Collection\'s title' do
            within 'div#show-modal' do
              expect(page).to have_text @collection.title
            end
          end

          scenario 'the User should see the Collection\'s notes' do
            within 'div#show-modal' do
              expect(page).to have_text @collection.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Collection', js: true do
        before :each do
          expect(@collection.persisted?).to be true
          within 'div#collections-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'

              find(:css, "#btn-collection-edit-#{@collection.id}").click
            end
          end
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector 'div#form-modal', visible: true
          end

          context 'changes the Collection\'s title' do
            let(:new_collection) do
              a = build :collection, title: Faker::Name.title, abbr: Faker::Lorem.characters(5)
              expect(a).to be_valid
              a
            end

            before :each do
              within 'div#form-modal' do
                fill_in Collection.human_attribute_name(:title), with: new_collection.title
              end
            end

            context 'and clicks on the "Update Collection" button' do
              before :each do
                within 'div#form-modal' do
                  click_on 'Update Collection'
                end
              end

              scenario 'then the Collection\'s title should be changed' do
                within 'div#collections-table' do
                  within "div#collection-#{@collection.id}.entity.row" do
                    expect(page).to have_text new_collection.title
                  end
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Collection', js: true do
        before :each do
          expect(@collection.persisted?).to be true
          within 'div#collections-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              find(:css, "#btn-collection-delete-#{@collection.id}").click
            end
          end

          scenario 'then the Collection gets deleted' do
            within 'div#collections-table' do
              expect(page).not_to have_selector "#collection-#{@collection.id}.entity.row"
            end
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              find(:css, "#btn-collection-delete-#{@collection.id}").click
            end
          end

          scenario 'then the Collection is kept' do
            within 'div#collections-table' do
              expect(page).to have_selector "#collection-#{@collection.id}.entity.row"
            end
          end
        end
      end
    end

    context 'and is associated to a Storage', with_db: true do
      before :each do
        @storage = create :storage
        @collection.storages << @storage
        @collection.save!

        visit collections_path
      end

      context 'when the User clicks on the "Edit" button of the first Collection', js: true do
        before :each do
          find(:css, "#btn-collection-edit-#{@collection.id}").click
          expect(page).to have_selector '#form-modal', visible: true

          within 'div#form-modal' do
            within 'ul#associate-storages' do
              expect(page).to have_text @storage.title
            end
          end
        end

        scenario 'then no further Storages should be associatable' do
          within 'ul#associate-storages' do
            expect(page).to have_text 'no unassociated Storages'
          end
        end

        feature 'and the User clicks on the "de-associate" button', skip: WITHOUT_AJAX do
          before :each do
            within 'div#form-modal' do
              find(:css, "#btn-deassoc-storage-#{@storage.id}").click
            end
          end

          scenario 'then the association is removed' do
            within 'div#form-modal' do
              expect(page).not_to have_text @storage.title
            end
            expect(Collection.find_by(id: @collection.id).storages).not_to include @storage
          end
        end
      end
    end

    context 'and a Storage exists', with_db: true do
      before :each do
        @storage = create :storage
      end

      context 'when the User clicks on the "Edit" button of the first Collection', js: true do
        before :each do
          find(:css, "#btn-collection-edit-#{@collection.id}").click
          expect(page).to have_selector '#form-modal', visible: true
        end

        scenario 'then further Storages should be associatable' do
          within 'ul#associate-storages' do
            expect(page).not_to have_text 'no unassociated Storages'
          end
        end

        context 'and the User enters the Storage\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in 'assoc-storage-input', with: @storage.title
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within 'div#form-modal' do
                find(:css, '#btn-associate-selected-storage').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Storage is associated with the Collection' do
              within 'div#form-modal' do
                expect(page).to have_text @storage.title
                expect(page).to have_text 'no unassociated Storages'
              end
              expect(Collection.find_by(id: @collection.id).storages).to include @storage
            end
          end
        end
      end
    end

    context 'and is associated to a Document', with_db: true do
      before :each do
        @document = create :document
        @collection.documents << @document
        @collection.save!

        visit collections_path
      end

      context 'when the User clicks on the "Edit" button of the first Collection', js: true do
        before :each do
          page.find(:css, "#btn-collection-edit-#{@collection.id}").click
          expect(page).to have_selector '#form-modal', visible: true

          within 'div#form-modal' do
            within 'ul#associate-documents' do
              expect(page).to have_text "#{@document.title} (#{@document.document_type})"
            end
          end
        end

        scenario 'then no further Documents should be associatable' do
          within 'ul#associate-documents' do
            expect(page).to have_text 'no unassociated Documents'
          end
        end

        feature 'and the User clicks on the "de-associate" button', skip: WITHOUT_AJAX do
          before :each do
            within 'div#form-modal' do
              find(:css, "#btn-deassoc-document-#{@document.id}").click
            end
          end

          scenario 'then the association is removed' do
            within 'div#form-modal' do
              expect(page).not_to have_text @document.title
              expect(page).not_to have_text @document.document_type
            end
            expect(Collection.find_by(id: @collection.id).documents).not_to include @document
          end
        end
      end
    end

    context 'and a Document exists', with_db: true do
      before :each do
        @document = create :document
      end

      context 'when the User clicks on the "Edit" button of the first Collection', js: true do
        before :each do
          find(:css, "#btn-collection-edit-#{@collection.id}").click
          expect(page).to have_selector '#form-modal', visible: true
        end

        scenario 'then further Documents should be associatable' do
          within 'ul#associate-documents' do
            expect(page).not_to have_text 'no unassociated Documents'
          end
        end

        context 'and the User enters the Document\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in 'assoc-document-input', with: "#{@document.title} (#{@document.document_type})"
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within 'div#form-modal' do
                find(:css, '#btn-associate-selected-document').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Document is associated with the Collection' do
              within 'div#form-modal' do
                expect(page).to have_text "#{@document.title} (#{@document.document_type})"
                expect(page).to have_text 'no unassociated Documents'
              end
              expect(Collection.find_by(id: @collection.id).documents).to include @document
            end
          end
        end
      end
    end
  end
end
