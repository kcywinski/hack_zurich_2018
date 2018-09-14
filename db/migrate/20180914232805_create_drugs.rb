class CreateDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :drugs do |t|
      t.integer :amount_left  
      t.integer :swissmedic_id
      t.string :name
      t.timestamps
    end
  end
end
