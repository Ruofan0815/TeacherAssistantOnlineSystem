class CreateClassTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :class_times do |t|
      t.string :day
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
