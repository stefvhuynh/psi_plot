class CreateTwoWayPlots < ActiveRecord::Migration
  def change
    create_table :two_way_plots do |t|
      t.string :title, null: false
      t.string :independent_name, null: false
      t.string :moderator_name, null: false
      t.string :dependent_name, null: false
      t.decimal :independent_coefficient, null: false
      t.decimal :moderator_coefficient, null: false
      t.decimal :interaction_coefficient, null: false
      t.decimal :intercept, null: false
      t.decimal :independent_mean, null: false
      t.decimal :independent_sd, null: false
      t.decimal :moderator_mean, null: false
      t.decimal :moderator_sd, null: false
      t.integer :order, null: false
      t.integer :project_id, null: false

      t.timestamps
    end

    add_index :two_way_plots, :title
    add_index :two_way_plots, [:order, :project_id], unique: true
  end
end
