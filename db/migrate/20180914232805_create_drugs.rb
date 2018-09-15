class CreateDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :drugs do |t|
      t.integer :swiss_id
      t.string :name            
      t.string :pack_type
      t.integer :tabs_number, default: 0      
      t.timestamps
    end
  end
end
