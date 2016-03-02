require 'rails_helper'

feature 'On the Archive Page', type: :feature do
  context 'and given an Archive exists', with_db: true do
    before :each do
      @archive = create :archive
    end

    context 'and given the User visits "/archives"' do
      before :each do
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
        scenario "with 'Home'" do
          expect(page).to have_breadcrumb 'Home'
        end

        scenario "with '#{Archive.model_name.plural.humanize}'" do
          expect(page).to have_breadcrumb Archive.model_name.plural.humanize
        end
      end

      feature 'when the User clicks on the "Show" button of the first Archive', js: true do
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
    end
  end
end
