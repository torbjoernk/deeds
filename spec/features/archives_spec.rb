require 'rails_helper'

feature 'On the Archive Page', type: :feature do
  before :each do
    visit archives_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Archive" button', js: true do
      let(:new_archive) { build :archive }

      before :each do
        page.find(:css, '#btn-new-archive').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector '#archive-modal', visible: true
        end

        context 'enters the new Archive\'s title' do
          before :each do
            within '#archive-modal' do
              fill_in 'Title', with: new_archive.title
            end
          end

          context 'and clicks on the "Create Archive" button', with_db: true do
            before :each do
              click_on 'Create Archive'
            end

            scenario 'then a new Archive with given title should be created' do
              within_table 'archives' do
                expect(page).to have_text new_archive.title
              end
            end
          end
        end
      end
    end
  end

  context 'given an Archive exists', with_db: true do
    before :each do
      @archive = create :archive
      visit archives_path
    end

    scenario 'then the User should see a table with archives' do
      expect(page).to have_table 'archives'

      within_table 'archives' do
        # exactly four columns
        expect(page).to have_selector 'thead > tr > th + th + th + th + th'
        expect(page).not_to have_selector 'thead > tr > th + th + th + th + th + th'

        within 'thead > tr > th:first-child' do
          expect(page).to have_text 'Title'
        end
        within 'thead > tr > th:nth-child(2)' do
          expect(page).to have_text 'Abbreviation'
        end
        within 'thead > tr > th:nth-child(3)' do
          expect(page).to have_text 'Notes'
        end
        within 'thead > tr > th:last-child' do
          expect(page).to have_text 'Actions'
        end
      end
    end

    context 'then the User should see the breadcrumbs' do
      scenario 'with "Home"' do
        expect(page).to have_breadcrumb 'Home'
      end

      scenario "with \"#{Archive.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Archive.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Archive', js: true do
        before :each do
          expect(@archive.persisted?).to be true
          within_table 'archives' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-archive-show-#{@archive.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector '#archive-modal', visible: true
          end

          scenario 'the User should see the Archive\'s title' do
            within '#archive-modal' do
              expect(page).to have_text @archive.title
            end
          end

          scenario 'the User should see the Archive\'s notes' do
            within '#archive-modal' do
              expect(page).to have_text @archive.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Archive', js: true do
        before :each do
          expect(@archive.persisted?).to be true
          within_table 'archives' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-archive-edit-#{@archive.id}").click
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector '#archive-modal', visible: true
          end

          context 'changes the Archive\'s title' do
            let(:new_archive) do
              a = build :archive, title: Faker::Name.title, abbr: Faker::Lorem.characters(5)
              expect(a).to be_valid
              a
            end

            before :each do
              within '#archive-modal' do
                fill_in 'Title', with: new_archive.title
              end
            end

            context 'and clicks on the "Update Archive" button' do
              before :each do
                within '#archive-modal' do
                  click_on 'Update Archive'
                end
              end

              scenario 'then the Archive\'s title should be changed' do
                within "#archive-row-#{@archive.id}" do
                  expect(page).to have_text new_archive.title
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Archive', js: true do
        before :each do
          expect(@archive.persisted?).to be true
          within_table 'archives' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              page.find(:css, "#btn-archive-delete-#{@archive.id}").click
            end
          end

          scenario 'then the Archive gets deleted' do
            expect(page).not_to have_selector "#archive-row-#{@archive.id}"
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              page.find(:css, "#btn-archive-delete-#{@archive.id}").click
            end
          end

          scenario 'then the Archive is kept' do
            expect(page).to have_selector "#archive-row-#{@archive.id}"
          end
        end
      end
    end
  end
end
