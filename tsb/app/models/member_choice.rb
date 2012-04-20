class MemberChoice < ActiveRecord::Base
  belongs_to :question
  validates :email, :presence =>true, :format=>/^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
  validates :selected_option, :presence =>true

end
