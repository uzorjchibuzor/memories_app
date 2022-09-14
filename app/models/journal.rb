class Journal < ApplicationRecord
  before_save { |journal| journal.title = journal.title.titleize }
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
