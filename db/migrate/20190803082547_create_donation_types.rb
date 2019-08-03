class CreateDonationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :donation_types do |t|
      t.string 'name', default: '', null: false

      t.timestamps
    end
  end
end
