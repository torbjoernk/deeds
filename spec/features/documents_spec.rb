require 'rails_helper'

feature 'On the Document Page', type: :feature do
  before :each do
    visit documents_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Document" button', js: true do
      let(:new_document) { build :document }

      before :each do
        page.find(:css, '#btn-new-document').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector 'div#form-modal', visible: true
        end

        context 'enters the new Document\'s title and type' do
          before :each do
            within 'div#form-modal' do
              fill_in Document.human_attribute_name(:title), with: new_document.title
              fill_in Document.human_attribute_name(:document_type), with: new_document.document_type
            end
          end

          context 'and clicks on the "Create Document" button', with_db: true do
            before :each do
              click_on 'Create Document'
            end

            scenario 'then a new Document with given title and type should be created' do
              within 'div#documents-table' do
                expect(page).to have_text new_document.title
                expect(page).to have_text new_document.document_type.humanize
              end
            end
          end
        end
      end
    end
  end

  context 'given a Document exists', with_db: true do
    before :each do
      @document = create :document
      visit documents_path
    end

    scenario 'then the User should see a table with Documents' do
      expect(page).to have_selector 'div#documents-table'
    end

    context 'then the User should see the breadcrumbs' do
      scenario 'with "Home"' do
        expect(page).to have_breadcrumb 'Home'
      end

      scenario "with \"#{Document.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Document.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Document', js: true do
        before :each do
          expect(@document.persisted?).to be true
          within 'div#documents-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-document-show-#{@document.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector 'div#show-modal', visible: true
          end

          scenario 'the User should see the Document\'s title' do
            within 'div#show-modal' do
              expect(page).to have_text @document.title
            end
          end

          scenario 'the User should see the Document\'s type' do
            within 'div#show-modal' do
              expect(page).to have_text @document.document_type
            end
          end

          scenario 'the User should see the Document\'s notes' do
            within 'div#show-modal' do
              expect(page).to have_text @document.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Document', js: true do
        before :each do
          expect(@document.persisted?).to be true
          within 'div#documents-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-document-edit-#{@document.id}").click
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector 'div#form-modal', visible: true
          end

          context 'changes the Document\'s title' do
            let(:new_document) do
              s = build :document, title: Faker::Name.title
              expect(s).to be_valid
              s
            end

            before :each do
              within 'div#form-modal' do
                fill_in Document.human_attribute_name(:title), with: new_document.title
              end
            end

            context 'and clicks on the "Update Document" button' do
              before :each do
                within 'div#form-modal' do
                  click_on 'Update Document'
                end
              end

              scenario 'then the Document\'s title should be changed' do
                within "div#document-#{@document.id}.entity.row" do
                  expect(page).to have_text new_document.title
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Document', js: true do
        before :each do
          expect(@document.persisted?).to be true
          within 'div#documents-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              find(:css, "#btn-document-delete-#{@document.id}").click
            end
          end

          scenario 'then the Document gets deleted' do
            expect(page).not_to have_selector "div#document-#{@document.id}.entity.row"
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              find(:css, "#btn-document-delete-#{@document.id}").click
            end
          end

          scenario 'then the Document is kept' do
            expect(page).to have_selector "div#document-#{@document.id}.entity.row"
          end
        end
      end
    end

    context 'and is associated to an Collection', with_db: true do
      before :each do
        @collection = create :collection
        @document.collections << @collection
        @document.save!

        visit documents_path
      end

      context 'when the User clicks on the "Edit" button of the first Document', js: true do
        before :each do
          find(:css, "#btn-document-edit-#{@document.id}").click
          expect(page).to have_selector 'div#form-modal', visible: true

          within 'div#form-modal' do
            within 'ul#associate-collections' do
              expect(page).to have_text @collection.title
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
              find(:css, "#btn-deassoc-collection-#{@collection.id}").click
            end
          end

          scenario 'then the association is removed' do
            within 'div#form-modal' do
              expect(page).not_to have_text @collection.title
            end
            expect(Document.find_by(id: @document.id).collections).not_to include @collection
          end
        end
      end
    end

    context 'and an Collection exists', with_db: true do
      before :each do
        @collection = create :collection
      end

      context 'when the User clicks on the "Edit" button of the first Document', js: true do
        before :each do
          find(:css, "#btn-document-edit-#{@document.id}").click
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
              fill_in 'assoc-collection-input', with: @collection.title
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within 'div#form-modal' do
                find(:css, '#btn-associate-selected-collection').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Collection is associated with the Document' do
              within 'div#form-modal' do
                expect(page).to have_text @collection.title
                expect(page).to have_text 'no unassociated Collections'
              end
              expect(Document.find_by(id: @document.id).collections).to include @collection
            end
          end
        end
      end
    end
  end
end
