class Entry < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  
  belongs_to :user
  belongs_to :journal

  validates :date, presence: true, uniqueness: { scope: :journal_id }
  validates_presence_of :body
end
