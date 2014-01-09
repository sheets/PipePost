class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :plan_key
      t.string :name
      t.decimal :price,:precision => 6, :scale => 2, :default => 0

      t.timestamps
    end
  end
end
