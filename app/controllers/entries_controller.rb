class EntriesController < ApplicationController
  include EntryHelper

  before_action :set_journal

  def index 
    
  end

  def new
    @entry = @journal.entries.new
  end

  def create
    @entry = @journal.entries.build(entry_params)
    @entry.user = current_user
    if @entry.save 
      redirect_to @journal
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params 
    params.require(:entry).permit(:body, :date, :journal_id)
  end
end