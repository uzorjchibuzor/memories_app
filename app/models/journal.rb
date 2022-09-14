class Journal < ApplicationRecord
  before_save { |journal| journal.title = journal.title.titleize }
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
