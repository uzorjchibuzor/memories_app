class Journal < ApplicationRecord
  default_scope { order(updated_at: :desc)}
  before_save { |journal| journal.title = journal.title.titleize }
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }

  after_create_commit :broadcast_to_user 

  private 

  def broadcast_to_user
    broadcast_prepend_later_to(
      user,
      :journals,
      target: 'journals',
      partial: 'journals/journal',
      locals: {
        journal: self
      }
    )
  end
end
