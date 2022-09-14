class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :journal

  validates :date, presence: true, uniqueness: { scope: :journal_id }
  validates_presence_of :body
end
