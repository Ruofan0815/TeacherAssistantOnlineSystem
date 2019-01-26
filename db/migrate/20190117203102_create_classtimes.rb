class CreateClasstimes < ActiveRecord::Migration[5.1]
  def change
    create_table :classtimes do |t|
      t.string :day
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
