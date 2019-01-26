class ChangeStudentToUser < ActiveRecord::Migration[5.1]
  def change
    rename_table :students, :users
  end
end
