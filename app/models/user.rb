class User < ApplicationRecord
  has_many :user_courses
  has_many :courses, through: :user_courses

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 105},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password


  def self.search(param)
    coursefound = (title_match(param) + coursenum_match(param)).uniq
    return nil unless coursefound
    coursefound
  end

  def self.title_match(param)
    matches('title', param)
  end

  def self.coursenum_match(param)
    matches('course_number', param)
  end

  def self.matches(field_name, param)
    Course.where("#{field_name} like?", "%#{param}%")
  end

  def has_take_course?(c_id)
    user_courses.where(course_id: c_id, relationtype: "take").count > 0
  end

end
