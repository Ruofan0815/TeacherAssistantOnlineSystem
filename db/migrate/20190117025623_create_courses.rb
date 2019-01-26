class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :course_number
      t.integer :section

      t.timestamps
    end
  end
end
