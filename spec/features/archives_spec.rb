require 'rails_helper'

feature 'On the Archive Page', type: :feature do
  before :each do
    visit archives_path
  end

  context 'when the User clicks' do
    feature 'on the "Create Archive" button', js: true do
      let(:new_archive) { build :archive }

      before :each do
        find(:css, '#btn-new-archive').click
      end

      context 'and, within the form modal,' do
        before :each do
          expect(page).to have_selector '#form-modal', visible: true
        end

        context 'enters the new Archive\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in Archive.human_attribute_name(:title), with: new_archive.title
            end
          end

          context 'and clicks on the "Create Archive" button', with_db: true do
            before :each do
              click_on 'Create Archive'
            end

            scenario 'then a new Archive with given title should be created' do
              within 'div#archives-table' do
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
      expect(page).to have_selector 'div#archives-table'
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
          within 'div#archives-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
          find(:css, "#btn-archive-show-#{@archive.id}").click
        end

        context 'then, within a modal,' do
          before :each do
            expect(page).to have_selector '#show-modal', visible: true
          end

          scenario 'the User should see the Archive\'s title' do
            within 'div#show-modal' do
              expect(page).to have_text @archive.title
            end
          end

          scenario 'the User should see the Archive\'s notes' do
            within 'div#show-modal' do
              expect(page).to have_text @archive.notes
            end
          end
        end
      end

      feature 'on the "Edit" button of the first Archive', js: true do
        before :each do
          expect(@archive.persisted?).to be true
          within 'div#archives-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'

              find(:css, "#btn-archive-edit-#{@archive.id}").click
            end
          end
        end

        context 'and, within the form modal,' do
          before :each do
            expect(page).to have_selector 'div#form-modal', visible: true
          end

          context 'changes the Archive\'s title' do
            let(:new_archive) do
              a = build :archive, title: Faker::Name.title, abbr: Faker::Lorem.characters(5)
              expect(a).to be_valid
              a
            end

            before :each do
              within 'div#form-modal' do
                fill_in Archive.human_attribute_name(:title), with: new_archive.title
              end
            end

            context 'and clicks on the "Update Archive" button' do
              before :each do
                within 'div#form-modal' do
                  click_on 'Update Archive'
                end
              end

              scenario 'then the Archive\'s title should be changed' do
                within 'div#archives-table' do
                  within "div#archive-#{@archive.id}.entity.row" do
                    expect(page).to have_text new_archive.title
                  end
                end
              end
            end
          end
        end
      end

      feature 'on the "Delete" button of the first Archive', js: true do
        before :each do
          expect(@archive.persisted?).to be true
          within 'div#archives-table' do
            within 'div.table-body' do
              expect(page).to have_css 'div.entity.row'
              expect(page).not_to have_css 'div.entity.row + div.entity.row'
            end
          end
        end

        context 'and confirms the confirmation' do
          before :each do
            accept_confirm do
              find(:css, "#btn-archive-delete-#{@archive.id}").click
            end
          end

          scenario 'then the Archive gets deleted' do
            within 'div#archives-table' do
              expect(page).not_to have_selector "#archive-#{@archive.id}.entity.row"
            end
          end
        end

        context 'and dismisses the confirmation' do
          before :each do
            dismiss_confirm do
              find(:css, "#btn-archive-delete-#{@archive.id}").click
            end
          end

          scenario 'then the Archive is kept' do
            within 'div#archives-table' do
              expect(page).to have_selector "#archive-#{@archive.id}.entity.row"
            end
          end
        end
      end
    end

    context 'and is associated to a Storage', with_db: true do
      before :each do
        @storage = create :storage
        @archive.storages << @storage
        @archive.save!

        visit archives_path
      end

      context 'when the User clicks on the "Edit" button of the first Archive', js: true do
        before :each do
          find(:css, "#btn-archive-edit-#{@archive.id}").click
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
            expect(Archive.find(@archive.id).storages).not_to include @storage
          end
        end
      end
    end

    context 'and a Storage exists', with_db: true do
      before :each do
        @storage = create :storage
      end

      context 'when the User clicks on the "Edit" button of the first Archive', js: true do
        before :each do
          find(:css, "#btn-archive-edit-#{@archive.id}").click
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

            scenario 'the Storage is associated with the Archive' do
              within 'div#form-modal' do
                expect(page).to have_text @storage.title
                expect(page).to have_text 'no unassociated Storages'
              end
              expect(Archive.find(@archive.id).storages).to include @storage
            end
          end
        end
      end
    end

    context 'and is associated to a Source', with_db: true do
      before :each do
        @source = create :source
        @archive.sources << @source
        @archive.save!

        visit archives_path
      end

      context 'when the User clicks on the "Edit" button of the first Archive', js: true do
        before :each do
          page.find(:css, "#btn-archive-edit-#{@archive.id}").click
          expect(page).to have_selector '#form-modal', visible: true

          within 'div#form-modal' do
            within 'ul#associate-sources' do
              expect(page).to have_text "#{@source.title} (#{@source.source_type})"
            end
          end
        end

        scenario 'then no further Sources should be associatable' do
          within 'ul#associate-sources' do
            expect(page).to have_text 'no unassociated Sources'
          end
        end

        feature 'and the User clicks on the "de-associate" button', skip: WITHOUT_AJAX do
          before :each do
            within 'div#form-modal' do
              find(:css, "#btn-deassoc-source-#{@source.id}").click
            end
          end

          scenario 'then the association is removed' do
            within 'div#form-modal' do
              expect(page).not_to have_text @source.title
              expect(page).not_to have_text @source.source_type
            end
            expect(Archive.find(@archive.id).sources).not_to include @source
          end
        end
      end
    end

    context 'and a Source exists', with_db: true do
      before :each do
        @source = create :source
      end

      context 'when the User clicks on the "Edit" button of the first Archive', js: true do
        before :each do
          find(:css, "#btn-archive-edit-#{@archive.id}").click
          expect(page).to have_selector '#form-modal', visible: true
        end

        scenario 'then further Sources should be associatable' do
          within 'ul#associate-sources' do
            expect(page).not_to have_text 'no unassociated Sources'
          end
        end

        context 'and the User enters the Sources\'s title' do
          before :each do
            within 'div#form-modal' do
              fill_in 'assoc-source-input', with: "#{@source.title} (#{@source.source_type})"
            end
          end

          feature 'and the User clicks on the "associate" button', skip: WITHOUT_AJAX do
            before :each do
              within 'div#form-modal' do
                find(:css, '#btn-associate-selected-source').click
                expect(page).to have_css '.form-control-success'
              end
            end

            scenario 'the Source is associated with the Archive' do
              within 'div#form-modal' do
                expect(page).to have_text "#{@source.title} (#{@source.source_type})"
                expect(page).to have_text 'no unassociated Sources'
              end
              expect(Archive.find(@archive.id).sources).to include @source
            end
          end
        end
      end
    end
  end
end