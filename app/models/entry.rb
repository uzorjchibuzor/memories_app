# frozen_string_literal: true

class Entry < ApplicationRecord
  default_scope { order(date: :desc) }

  belongs_to :user
  belongs_to :journal

  validates :date, presence: true, uniqueness: { scope: :journal_id }
  validates :thoughts, presence: true, length: { minimum: 10}

  broadcasts_to ->(entry) { [entry.journal, :entries] }, inserts_by: :prepend
end
