class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :journal, null: false, foreign_key: true
      t.date :date
      t.text :body

      t.timestamps
    end
  end
end