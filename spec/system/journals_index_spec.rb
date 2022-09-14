RSpec.describe "Journals Index", type: :system do
  context "when a user is not signed in" do
    it "redirects the user to the sign in page" do
      visit root_path
      expect(page).not_to have_content("You need to sign in or sign up before continuing")
    end
  end
end