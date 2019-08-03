class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.references :user, index: true
      t.references :donation_type, index: true
      t.datetime :date, null: false

      t.timestamps
    end
    add_index :donations, [:donation_type_id, :user_id]
  end
end
