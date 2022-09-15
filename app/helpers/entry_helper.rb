module EntryHelper
  def set_journal
    @journal ||= Journal.find(params[:journal_id])
  end
end