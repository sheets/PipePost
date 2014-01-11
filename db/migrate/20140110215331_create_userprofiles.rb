class CreateUserprofiles < ActiveRecord::Migration
  def change
    create_table :userprofiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :country
      t.text :address
      t.text :mailing_address
      t.integer :zip
      t.string :city
      t.string :state
      t.date :age
      t.integer :phone
      t.references :user

      t.timestamps
    end
    add_index :userprofiles, :user_id
  end
end
