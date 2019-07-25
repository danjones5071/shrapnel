class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :issue_type, null: false, limit: 32
      t.string :subject, null: false, limit: 32
      t.text :description
      t.string :issue_status, null: false
      t.string :assignee
      t.integer :estimate
      t.date :due_date

      t.timestamps
    end
  end
end
