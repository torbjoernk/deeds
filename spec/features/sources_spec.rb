require 'rails_helper'

feature 'On the Source Page', type: :feature do
  before :each do
    visit sources_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Source" button', js: true do
      let(:new_source) { build :source }

      before :each do
        page.find(:css, '#btn-new-source').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector '#source-modal', visible: true
        end

        context 'enters the new Source\'s title and type' do
          before :each do
            within '#source-modal' do
              fill_in Source.human_attribute_name(:title), with: new_source.title
              fill_in Source.human_attribute_name(:source_type), with: new_source.source_type
            end
          end

          context 'and clicks on the "Create Source" button', with_db: true do
            before :each do
              click_on 'Create Source'
            end

            scenario 'then a new Source with given title and type should be created' do
              within_table 'sources' do
                expect(page).to have_text new_source.title
                expect(page).to have_text new_source.source_type
              end
            end
          end
        end
      end
    end
  end

  context 'given a Source exists', with_db: true do
    before :each do
      @source = create :source
      visit sources_path
    end

    scenario 'then the User should see a table with Sources' do
      expect(page).to have_table 'sources'

      within_table 'sources' do
        # exactly five columns
        expect(page).to have_selector 'thead > tr > th + th + th + th + th'
        expect(page).not_to have_selector 'thead > tr > th + th + th + th + th + th'

        within 'thead > tr > th:first-child' do
          expect(page).to have_text Source.human_attribute_name(:title)
        end
        within 'thead > tr > th:nth-child(2)' do
          expect(page).to have_text Source.human_attribute_name(:source_type)
        end
        within 'thead > tr > th:nth-child(3)' do
          expect(page).to have_text Source.human_attribute_name(:notes)
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

      scenario "with \"#{Source.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Source.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Source', js: true do
        before :each do
          expect(@source.persisted?).to be true
          within_table 'sources' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-source-show-#{@source.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector '#source-modal', visible: true
          end

          scenario 'the User should see the Source\'s title' do
            within '#source-modal' do
              expect(page).to have_text @source.title
            end
          end

          scenario 'the User should see the Source\'s type' do
            within '#source-modal' do
              expect(page).to have_text @source.source_type
            end
          end

          scenario 'the User should see the Source\'s notes' do
            within '#source-modal' do
              expect(page).to have_text @source.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Source', js: true do
        before :each do
          expect(@source.persisted?).to be true
          within_table 'sources' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-source-edit-#{@source.id}").click
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector '#source-modal', visible: true
          end

          context 'changes the Source\'s title' do
            let(:new_source) do
              s = build :source, title: Faker::Name.title
              expect(s).to be_valid
              s
            end

            before :each do
              within '#source-modal' do
                fill_in Source.human_attribute_name(:title), with: new_source.title
              end
            end

            context 'and clicks on the "Update Source" button' do
              before :each do
                within '#source-modal' do
                  click_on 'Update Source'
                end
              end

              scenario 'then the SOurce\'s title should be changed' do
                within "#source-row-#{@source.id}" do
                  expect(page).to have_text new_source.title
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Source', js: true do
        before :each do
          expect(@source.persisted?).to be true
          within_table 'sources' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              page.find(:css, "#btn-source-delete-#{@source.id}").click
            end
          end

          scenario 'then the Source gets deleted' do
            expect(page).not_to have_selector "#source-row-#{@source.id}"
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              page.find(:css, "#btn-source-delete-#{@source.id}").click
            end
          end

          scenario 'then the Source is kept' do
            expect(page).to have_selector "#source-row-#{@source.id}"
          end
        end
      end
    end

    context 'and is associated to an Archive', with_db: true do
      before :each do
        @archive = create :archive
        @source.archives << @archive
        @source.save!

        visit sources_path
      end

      context 'when the User clicks on the "Edit" button of the first Source', js: true do
        before :each do
          page.find(:css, "#btn-source-edit-#{@source.id}").click
          expect(page).to have_selector '#source-modal', visible: true

          within '#source-modal' do
            within '#associate-archives' do
              expect(page).to have_text @archive.title
            end
          end
        end

        scenario 'then no further Archives should be associatable' do
          within '#associate-archives' do
            expect(page).to have_text 'no unassociated Archives'
          end
        end

        feature 'and the User clicks on the "de-associate" button', skip: WITHOUT_AJAX do
          before :each do
            within '#source-modal' do
              find(:css, "#btn-deassoc-archive-#{@archive.id}").click
            end
          end

          scenario 'then the association is removed' do
            within '#source-modal' do
              expect(page).not_to have_text @archive.title
            end
            expect(Source.find(@source.id).archives).not_to include @archive
          end
        end
      end
    end

    context 'and an Archive exists', with_db: true do
      before :each do
        @archive = create :archive
      end

      context 'when the User clicks on the "Edit" button of the first Source', js: true do
        before :each do
          page.find(:css, "#btn-source-edit-#{@source.id}").click
          expect(page).to have_selector '#source-modal', visible: true
        end

        scenario 'then further Archives should be associatable' do
          within '#associate-archives' do
            expect(page).not_to have_text 'no unassociated Archives'
          end
        end

        context 'and the User enters the Archive\'s title' do
          before :each do
            within '#source-modal' do
              fill_in 'assoc-archive-input', with: @archive.title
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within '#source-modal' do
                find(:css, '#btn-associate-selected-archive').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Archive is associated with the Source' do
              within '#source-modal' do
                expect(page).to have_text @archive.title
                expect(page).to have_text 'no unassociated Archives'
              end
              expect(Source.find(@source.id).archives).to include @archive
            end
          end
        end
      end
    end
  end
end
