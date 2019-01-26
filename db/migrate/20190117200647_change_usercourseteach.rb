class ChangeUsercourseteach < ActiveRecord::Migration[5.1]
  def change
    rename_table :usercourse_teaches, :user_course_teaches
  end
end
