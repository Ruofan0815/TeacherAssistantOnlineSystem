class Classtime < ApplicationRecord
  has_many :course_classtimes
  has_many :courses, through: :course_classtimes
end
