class SchwagWinner < ActiveRecord::Base
  belongs_to :versus
  belongs_to :member
end
