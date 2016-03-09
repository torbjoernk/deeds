require 'rails_helper'

feature 'On the Content Page', type: :feature do
  before :each do
    visit contents_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Content" button', js: true do
      let(:new_content) { build :content }

      before :each do
        page.find(:css, '#btn-new-content').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector '#form-modal', visible: true
        end

        context 'enters the new Contents\'s language and content' do
          before :each do
            within '#form-modal' do
              select new_content.language.humanize, from: Content.human_attribute_name(:language)
              fill_in Content.human_attribute_name(:content), with: new_content.content
            end
          end

          context 'and clicks on the "Create Content" button', with_db: true do
            before :each do
              click_on 'Create Content'
            end

            scenario 'then a new Content with given language and content should be created' do
              within_table 'contents' do
                expect(page).to have_text new_content.language.humanize
                expect(page).to have_text new_content.content
              end
            end
          end
        end
      end
    end
  end

  context 'given a Content exists', with_db: true do
    before :each do
      @content = create :content
      visit contents_path
    end

    scenario 'then the User should see a table with Contents' do
      expect(page).to have_table 'contents'

      within_table 'contents' do
        # exactly four columns
        expect(page).to have_selector 'thead > tr > th + th + th + th'
        expect(page).not_to have_selector 'thead > tr > th + th + th + th + th'

        within 'thead > tr > th:first-child' do
          expect(page).to have_text Content.human_attribute_name(:language)
        end
        within 'thead > tr > th:nth-child(2)' do
          expect(page).to have_text Content.human_attribute_name(:content)
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

      scenario "with \"#{Content.model_name.plural.humanize}\"" do
        expect(page).to have_breadcrumb Content.model_name.plural.humanize
      end
    end

    context 'when the User clicks' do
      feature 'on the "Show" button of the first Content', js: true do
        before :each do
          expect(@content.persisted?).to be true
          within_table 'contents' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-content-show-#{@content.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector '#show-modal', visible: true
          end

          scenario 'the User should see the Contents\'s langauge' do
            within '#show-modal' do
              expect(page).to have_text @content.language.humanize
            end
          end

          scenario 'the User should see the Contents\'s content' do
            within '#show-modal' do
              expect(page).to have_text @content.content
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Content', js: true do
        before :each do
          expect(@content.persisted?).to be true
          within_table 'contents' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
          page.find(:css, "#btn-content-edit-#{@content.id}").click
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector '#form-modal', visible: true
          end

          context 'changes the Content\'s content' do
            let(:new_content) do
              c = build :content, content: Faker::Lorem.paragraph(2)
              expect(c).to be_valid
              c
            end

            before :each do
              within '#form-modal' do
                fill_in Content.human_attribute_name(:content), with: new_content.content
              end
            end

            context 'and clicks on the "Update Content" button' do
              before :each do
                within '#form-modal' do
                  click_on 'Update Content'
                end
              end

              scenario 'then the Content\'s content should be changed' do
                within "#content-row-#{@content.id}" do
                  expect(page).to have_text new_content.content
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Content', js: true do
        before :each do
          expect(@content.persisted?).to be true
          within_table 'contents' do
            within 'tbody' do
              expect(page).to have_css 'tr'
              expect(page).not_to have_css 'tr + tr'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              page.find(:css, "#btn-content-delete-#{@content.id}").click
            end
          end

          scenario 'then the Content gets deleted' do
            expect(page).not_to have_selector "#content-row-#{@content.id}"
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              page.find(:css, "#btn-content-delete-#{@content.id}").click
            end
          end

          scenario 'then the Content is kept' do
            expect(page).to have_selector "#content-row-#{@content.id}"
          end
        end
      end
    end
  end
end
