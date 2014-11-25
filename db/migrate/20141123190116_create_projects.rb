class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.integer :order, null: false
      t.text :description
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :projects, :name
    add_index :projects, :user_id
  end
end
