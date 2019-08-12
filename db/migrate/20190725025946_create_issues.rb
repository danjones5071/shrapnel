class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :assignee
      t.text :description
      t.date :due_date
      t.integer :estimate
      t.string :issue_status, null: false
      t.string :issue_type, null: false, limit: 32
      t.string :subject, null: false, limit: 32
      
      t.timestamps
    end
  end
end
