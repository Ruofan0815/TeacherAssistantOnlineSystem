class ChangeClasstimeToCtime < ActiveRecord::Migration[5.1]
  def change
    rename_table :class_times, :ctimes
  end
end
