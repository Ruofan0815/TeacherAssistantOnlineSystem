class Course < ApplicationRecord
  has_many :user_courses
  has_many :users, through: :user_courses

  has_many :course_classtimes
  has_many :classtimes, through: :course_classtimes

  def teacher_assistants
    usercourses = UserCourse.where(:course_id=>self.id, :relationtype=>"teach")
    tas = Array.new
    usercourses.each do |uc|
      @ta = User.find(uc.user_id)
      tas.push(@ta)
    end
    return tas
  end

end
