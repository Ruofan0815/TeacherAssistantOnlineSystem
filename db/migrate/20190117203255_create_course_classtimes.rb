class CreateCourseClasstimes < ActiveRecord::Migration[5.1]
  def change
    create_table :course_classtimes do |t|
      t.references :course, foreign_key: true
      t.references :classtime, foreign_key: true

      t.timestamps
    end
  end
end
