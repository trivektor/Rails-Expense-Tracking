class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.string :name
      t.float :amount
      t.float :tax
      t.float :tip
      t.string :category
      t.text :description
      t.datetime :originally_created_at
      t.timestamps
    end
  end
end
