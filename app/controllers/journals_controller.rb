# frozen_string_literal: true

# Journals Controller actions are defined here
class JournalsController < ApplicationController
  def new
    @journal = Journal.new
  end

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Journal was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Journal was successfully created.' }
      end
      
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @journal = current_user.journals.find_by(id: params[:id])
  end

  def show
    @journal = current_user.journals.find_by(id: params[:id])
    @journal_entries = @journal.entries
    @entry = @journal.entries.new
  end

  def update
    @journal = current_user.journals.find_by(id: params[:id])
    redirect_to @journal if @journal.update_attribute(:title, params[:title])
  end

  def destroy; end

  private

  def journal_params
    params.require(:journal).permit(:title, :is_private)
  end
end
