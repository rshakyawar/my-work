class MembershipCode < ActiveRecord::Base

  validates_uniqueness_of :value
  validates_presence_of  :value
  has_many :members, :dependent=>:nullify

  def validate_membership_code
    #format_type = self.find_format
    #return_from_usage_limit = self.usage_limit if format_type.to_s == "number_of_uses"
    #return_from_time_sensitive = self.time_sensitive if format_type.to_s == "limit"
    #return true if return_from_usage_limit or return_from_time_sensitive
    #return false 
    ((self.find_format) == "number_of_uses")? self.usage_limit : self.time_sensitive
  end

  def usage_limit
    #if !(self.number_of_uses.nil?) and self.number_of_uses > 0
      #return true if self.number_of_uses >0 
    #end
    #return false
    (!self.number_of_uses.nil? and self.number_of_uses >0)? true : false
  end
  
  def time_sensitive
    if !(self.limit.nil?)
      currnt_utc = Time.now.utc + 5.5.hours
      code_create_time = self.activated_at 
      time_hours_difference= (currnt_utc.to_time - code_create_time.to_time)/3600
      return true if time_hours_difference < self.limit.to_f
    end
    return false
  end
  
  def find_format
    self.number_of_uses.nil? ? "limit" : "number_of_uses"
  end
  
  def save_number_of_uses
    self.number_of_uses -= 1 
    self.save
  end
end
