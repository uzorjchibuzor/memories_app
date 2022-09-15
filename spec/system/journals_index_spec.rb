# frozen_string_literal: true

RSpec.describe 'Journals Index', type: :system do # rubocop:disable Metrics/BlockLength
  context 'when a user is not signed in' do
    it 'redirects the user to the sign in page' do
      visit root_path
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end

  context 'when a user is signed in' do # rubocop:disable Metrics/BlockLength
    let!(:user) { create(:user) }
    let!(:user_journal) { create(:journal, user:) }

    before :each do
      login_as user, scope: :user
      visit root_path
    end

    it 'displays the index page containing user journals if the user has journals' do
      expect(page).not_to have_content('You need to sign in or sign up before continuing')
      expect(page).to have_content(user.name)
      expect(page).to have_content(user_journal.title)
    end

    it 'allow the user to create a new journal with valid attributes' do
      expect(page).to have_selector(:link_or_button, 'New Journal')

      click_on 'New Journal'

      expect(page).to have_selector(:link_or_button, 'CREATE JOURNAL')
      expect(page).to have_selector(:link_or_button, 'CANCEL')
      expect(page).to have_field('journal_title')

      fill_in('journal_title', with: 'A New Journal')
      click_on 'CREATE JOURNAL'
      expect(page).to have_content('A New Journal')
    end

    it "allows the user to edit a quote title" do
      expect(page).to have_selector(:link_or_button, 'Edit')

      click_on 'Edit'
      fill_in 'journal_title',	with: 'edited journal for testing'
      click_on 'UPDATE JOURNAL'

      expect(page).to have_content('Journal was successfully updated.')
      expect(page).to have_content('Edited Journal For Testing') # The journal model titlecase title attribute on save
    end

    it "allows the user to delete a quote" do
      expect(page).to have_selector(:link_or_button, 'Delete')

      accept_confirm do
        click_on 'Delete'
      end

      expect(page).to have_content('Journal was successfully destroyed.')
    end
    
    it 'does not allow a signed in user to save new journal with invalid attributes' do
      expect(page).to have_selector(:link_or_button, 'New Journal')

      click_on 'New Journal'

      expect(page).to have_selector(:link_or_button, 'CREATE JOURNAL')
      expect(page).to have_selector(:link_or_button, 'CANCEL')
      expect(page).to have_field('journal_title')

      fill_in('journal_title', with: '')
      click_on 'CREATE JOURNAL'
      expect(page).to have_content("Title can't be blank")
    end
  end
end
