# frozen_string_literal: true

RSpec.describe 'Journals show page', type: :system do # rubocop:disable Metrics/BlockLength
  context 'when a user is signed in' do # rubocop:disable Metrics/BlockLength
    let!(:user) { create(:user) }
    let!(:user_journal) { create(:journal, user:) }
    let!(:user_journal_entry) { create(:entry, journal: user_journal, user:) }

    before :each do
      login_as user, scope: :user
      visit root_path
      click_on user_journal.title
    end

    it 'display the title of the journal and lists the entries in the journal if present' do
      expect(page).to have_content('Back to Journals')
      expect(page).to have_selector(:link_or_button, 'New Entry')
      expect(page).to have_content(user_journal_entry.thoughts)
    end

    it 'allows the user to edit their entries' do
      click_on 'Edit'
      expect(page).to have_selector(:link_or_button, 'UPDATE ENTRY')  
      expect(page).to have_selector(:link_or_button, 'CANCEL') 
      page.execute_script("document.getElementById('entry_thoughts_trix_input_entry_#{user_journal_entry.id}').value = '<div>The thoughts have been edited</div>'")

      click_on 'UPDATE ENTRY'

      expect(page).to have_content('Your entry has been updated successfully')
      expect(page).to have_content('The thoughts have been edited')
    end

    it 'allows a user to delete their entries' do
      accept_confirm do
        click_on 'Delete'
      end
      expect(page).to have_content('Your entry has been deleted successfully')
      expect(page).not_to have_content(user_journal_entry.thoughts)
    end

    it 'returns user to back to the new page when invalid parameters are entered' do
      click_on 'New Entry'

      expect(page).to have_selector(:link_or_button, 'CREATE ENTRY')  
      expect(page).to have_selector(:link_or_button, 'CANCEL') 

      page.execute_script("document.getElementById('entry_thoughts_trix_input_entry').value = ''")

      fill_in 'entry_date', with: "''"
      click_on 'CREATE ENTRY'

      expect(page).to have_content('Your entry has been created successfully')
    end


    it 'allows the user to create a new entry' do
      click_on 'New Entry'

      expect(page).to have_selector(:link_or_button, 'CREATE ENTRY')  
      expect(page).to have_selector(:link_or_button, 'CANCEL') 

      page.execute_script("document.getElementById('entry_thoughts_trix_input_entry').value = '<div>This is a new entry created for testing</div>'")

      fill_in 'entry_date', with: Date.yesterday
      click_on 'CREATE ENTRY'

      expect(page).to have_content('Your entry has been created successfully')
      expect(page).to have_content('This is a new entry created for testing')
    end
  end
end
