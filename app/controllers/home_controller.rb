class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_journals = current_user.journals
  end
end
