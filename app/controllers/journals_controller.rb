# frozen_string_literal: true

# Journals Controller actions are defined here
class JournalsController < ApplicationController
  before_action :set_journal, except: [:new, :create]
  before_action :authenticate_user!

  def new
    @journal = current_user_journals.new
  end

  def create
    @journal = current_user_journals.build(journal_params)
    if @journal.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Journal was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Journal was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def show
    return  redirect_to root_path, notice: 'You are not authorized to access this resource.' if @journal.nil?

    @journal_entries = @journal.entries 
    @entry = @journal.entries.new
  end

  def update
    return unless @journal.update(journal_params)

    respond_to do |format|
      format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
      format.turbo_stream { flash.now[:notice] = 'Journal was successfully updated.' }
    end
  end

  def destroy
    @journal.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Journal was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Journal was successfully destroyed.' }
    end
  end

  private

  def set_journal
    @journal = current_user_journals.find_by(id: params[:id])
  end

  def journal_params
    params.require(:journal).permit(:title, :is_private)
  end

  def current_user_journals
    @journals ||= current_user.journals
  end
end
