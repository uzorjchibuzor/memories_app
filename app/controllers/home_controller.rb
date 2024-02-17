# frozen_string_literal: true

# This is the controller class in charge of the landing page after successfull sign in.
class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_journals = (current_user.journals + Journal.where(is_private: false)).uniq
    @journal = Journal.new
  end
end
