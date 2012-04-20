class MemberVote < ActiveRecord::Base
  belongs_to :question
  belongs_to :member
end
