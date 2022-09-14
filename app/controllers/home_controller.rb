class HomeController < ApplicationController
  def index
    @user_journals = current_user.journals
  end
end
