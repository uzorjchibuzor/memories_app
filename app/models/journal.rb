# frozen_string_literal: true

class Journal < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  before_save { |journal| journal.title = journal.title.titleize }
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }

  broadcasts_to ->(journal) { [journal.user, :journals] }, inserts_by: :prepend
end
