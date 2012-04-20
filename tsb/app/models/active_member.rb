class ActiveMember < Member

  default_scope :conditions => ["active = ?", true]

end
