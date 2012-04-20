class MemberSurveyOne < ActiveRecord::Base
  ATTRIBUTES = {"sms"=>nil, "calls"=>nil, "email"=>nil, "social_networking"=>nil, "humans"=>nil}
  MINIMUM_SELECTION = 5
  belongs_to :member

  validate :three_present?

  def three_present?
    selection, columns = 0, %w(sms calls email social_networking humans)
    columns.each {|attr| selection += 1 if self[attr].blank? }
    errors.add_to_base("Please select one option from each category") if selection > columns.size - MINIMUM_SELECTION
  end

end
