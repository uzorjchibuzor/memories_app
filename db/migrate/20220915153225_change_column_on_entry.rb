class ChangeColumnOnEntry < ActiveRecord::Migration[7.0]
  def change
    rename_column :entries, :body, :thoughts
  end
end
