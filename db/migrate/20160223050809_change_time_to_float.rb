class ChangeTimeToFloat < ActiveRecord::Migration
  def change
    change_column :switches, :time, :float
  end
end
