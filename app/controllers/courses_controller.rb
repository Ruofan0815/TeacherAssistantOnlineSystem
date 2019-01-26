class CoursesController < ApplicationController
  before_action :set_course, only: [:show]
  before_action :require_login
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: 10);
  end

  def show
    @teachers = @course.teacher_assistants
    # puts "length: " + @teachers.length.to_s
    @teacher_ids = Array.new
    @teachers.each do |teacher|
      @teacher_ids.push(teacher.id)
    end
    @users = User.all.sort_by &:first_name
    @reorder_users = Array.new
    @users.each do |user|
      if @teacher_ids.include?(user.id)
        @reorder_users.push(user)
      end
    end

    @users.each do |user|
      if !time_conflict(user, @course) && !@teacher_ids.include?(user.id)
        @reorder_users.push(user)
      end
    end

    @conflict_users = Array.new

    @users.each do |user|
      if time_conflict(user, @course) && !@teacher_ids.include?(user.id)
        @reorder_users.push(user)
        @conflict_users.push(user.id)
      end
    end
    puts "cuser: " + @conflict_users.count.to_s
  end

  def time_conflict(user, course)
    coursetime = course.course_classtimes
    coursetime_arr = Array.new
    coursetime.each do |courset|
      coursetime_arr.push(Classtime.find(courset.classtime_id))
    end


    # check to if exist a time conflict with take courses
    takecourses = user.user_courses.where(relationtype:"take")
    takecourses.each do |tcourse|
      tcoursetime = Course.find(tcourse.course_id).course_classtimes
      classtime_arr = Array.new
      tcoursetime.each do |cct|
        classtime_arr.push(Classtime.find(cct.classtime_id))
      end
      # puts "classtime_arr : " + classtime_arr.count.to_s
      classtime_arr.each do |t|
        coursetime_arr.each do |ct|
          if overlap(t, ct)
            return true
          end
        end
      end
    end

    #check to see if it has a time conflict with teach courses
    teachcourses = user.user_courses.where(relationtype:"teach")
    teachcourses.each do |tcourse|
      tcoursetime = Course.find(tcourse.course_id).course_classtimes
      classtime_arr = Array.new
      tcoursetime.each do |cct|
        classtime_arr.push(Classtime.find(cct.classtime_id))
      end
  
      classtime_arr.each do |t|
        coursetime_arr.each do |ct|
          if overlap(t, ct)
            return true
          end
        end
      end
    end

    return false
  end

  def overlap(course1, course2)
    start1 = convert_time(course1.start, course1.day)
    end1 = convert_time(course1.end, course1.day)
    start2 = convert_time(course2.start, course2.day)
    end2 = convert_time(course2.end, course2.day)

    if start1 > end2 || start2 > end1
      return false
    end
    return true
  end

  def convert_time(str_time, day)
    table = {"M" => 1, "T" => 2, "W" => "3", "R" => "4", "F" => "5"}
    arr = str_time.split(' ')
    am_pm = arr[1]
    times = arr[0].split(':')
    unix_time = (table[day].to_i-1)*24*60
    unix_time += times[0].to_i * 60
    unix_time += times[1].to_i
    if am_pm == "pm"
      unix_time += 12*60
    end
    return unix_time
  end

  def add_teacher
    # delete the original relationship
    @course = Course.find(params[:token])
    @teachers = @course.teacher_assistants
    @teachers.each do |teacher|
      @teachcourse = @course.user_courses.where(user_id:teacher.id, relationtype:"teach").first
      @teachcourse.destroy
    end

    key_list = params.keys()
    key_list.each do |key|
      if key.start_with?("user")
        user_id = key[4..-1].to_i
        puts user_id
        relation = @course.user_courses.build(user_id: user_id, relationtype:"teach")
        relation.save
      end
    end
    redirect_to course_path(@course)
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end
end
