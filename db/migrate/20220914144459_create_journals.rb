# frozen_string_literal: true

class CreateJournals < ActiveRecord::Migration[7.0]
  def change
    create_table :journals do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_private, default: true
      t.string :title

      t.timestamps
    end
  end
end
