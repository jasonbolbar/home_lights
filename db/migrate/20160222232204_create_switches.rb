class CreateSwitches < ActiveRecord::Migration
  def change
    create_table :switches do |t|
      t.string :name, null: false
      t.integer :pin_number, null: false
      t.boolean :status, default: false
      t.integer :time
      t.timestamps null: false
    end

    add_index :switches, :pin_number, unique: true
  end
end
