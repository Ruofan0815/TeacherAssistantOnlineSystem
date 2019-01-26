class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show]
  before_action :require_admin, only: [:index]
  before_action :require_same_user, only: [:show]
  def new
    @user = User.new
  end

  def index
    @users = User.where(admin:false).paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @relationship = UserCourse.where(:user_id=>@user.id, :relationtype=>"take")
    @takingCourses = Array.new
    @relationship.each do |rs|
      @takingCourses.push(Course.find(rs.course_id))
    end
    @relationshipTeach = UserCourse.where(:user_id=>@user.id, :relationtype=>"teach")
    @teachingCourses = Array.new
    @relationshipTeach.each do |rs|
      @teachingCourses.push(Course.find(rs.course_id))
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to USC TA Distribution System"
      redirect_to courses_path
    else
      flash.now[:danger] = "Something wrong with your information"
      render 'new'
    end
  end

  def add_course
    @relationship = UserCourse.where(:user_id=>current_user.id, :relationtype=>"take")
    @takingCourses = Array.new
    @relationship.each do |rs|
      @takingCourses.push(Course.find(rs.course_id))
    end
  end

  def add_takecourse
    @user = User.find(params[:user])
    relation = @user.user_courses.build(course_id: params[:course], relationtype:"take")
    relation.save
    redirect_to add_courses_path
  end

  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @courses = User.search(params[:search_param])
      flash.now[:danger] = "No matched course" if @courses.blank?
    end
    respond_to do |format|
      format.js {render partial: 'usercourse/result'}
    end
  end

  def removetake
    @user = User.find(params[:user])
    @teachcourse = @user.user_courses.where(course_id: params[:course], relationtype:"take").first
    @teachcourse.destroy
    redirect_to add_courses_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only access your own account"
      redirect_to root_path
    end
  end
end
