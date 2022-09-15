# frozen_string_literal: true

# All actions regarding the entry object lives here.
class EntriesController < ApplicationController
  before_action :set_journal
  before_action :set_entry, only: %i[edit update destroy]

  def index; end

  def new
    @entry = @journal.entries.new
  end

  def create
    @entry = @journal.entries.build(entry_params)
    @entry.user = current_user
    if @entry.save
      respond_to do |format|
        format.html { redirect_to @journal, notice: 'Your entry has been created successfully' }
        format.turbo_stream { flash.now[:notice] = 'Your entry has been created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    return unless @entry.update(entry_params)

    respond_to do |format|
      format.html { redirect_to @journal, notice: 'Your entry has been updated successfully' }
      format.turbo_stream { flash.now[:notice] = 'Your entry has been updated successfully' }
    end
  end

  def destroy
    return unless @entry.destroy

    respond_to do |format|
      format.html { redirect_to @journal, notice: 'Your entry has been deleted successfully' }
      format.turbo_stream { flash.now[:notice] = 'Your entry has been deleted successfully' }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:thoughts, :date)
  end

  def set_journal
    @journal ||= Journal.find(params[:journal_id])
  end

  def set_entry
    @entry ||= Entry.find(params[:id])
  end
end
