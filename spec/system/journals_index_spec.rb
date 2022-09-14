RSpec.describe 'Journals Index', type: :system do
  context 'when a user is not signed in' do
    it 'redirects the user to the sign in page' do
      visit root_path
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end

  context 'when a user is signed in' do
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

    it 'allow a signed in user to create a new journal with valid attributes' do
      expect(page).to have_selector(:link_or_button, 'New Journal')

      click_on 'New Journal'

      expect(page).to have_selector(:link_or_button, 'CREATE JOURNAL')
      expect(page).to have_selector(:link_or_button, 'CANCEL')
      expect(page).to have_field('journal_title')

      fill_in('journal_title', with: 'A New Journal')
      click_on "CREATE JOURNAL"
      expect(page).to have_content('A New Journal')
    end

    it 'does not allow a signed in user to create a new journal with invalid attributes' do
      expect(page).to have_selector(:link_or_button, 'New Journal')

      click_on 'New Journal'

      expect(page).to have_selector(:link_or_button, 'CREATE JOURNAL')
      expect(page).to have_selector(:link_or_button, 'CANCEL')
      expect(page).to have_field('journal_title')

      fill_in('journal_title', with: '')
      click_on "CREATE JOURNAL"
      expect(page).to have_content("Title can't be blank")
    end
  end
end
