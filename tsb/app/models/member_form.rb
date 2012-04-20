class MemberForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

   attr_accessor :first_name, :last_name, :email, :stash_name, :password, :b_day, :zip, :city, :state, :my_mail_goes_to, :member,:gender

  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
  validates_format_of :stash_name, :with => /^[a-zA-Z\d ]*$/i, :message => "can only contain letters and numbers."
  validates_format_of :password, :with => /^[a-zA-Z\d ]*$/i, :message => "can only contain letters and numbers."    
  validates_presence_of :email,:gender  
  validates :password, :presence =>true,:length => { :minimum => 6, :maximum => 10 },:confirmation =>true
  validates :stash_name,:presence =>true,:length => { :minimum => 3, :maximum => 10}  
  validate :member_uniqueness_of_email, :member_uniqueness_of_stash_name
  validate :date_format_change
  #validate :aagreement_accept_term_conditions
  
  validate do |member|
    member.errors.add_to_base("B'day can't be blank") if member.b_day.blank?
  end
  
  
  def aagreement_accept_term_conditions
    errors.add_to_base("Please accept the Terms of Use and privacy policy") if accept_term_conditions.to_i != 1
  end

  
  def initialize(attributes = {})
    @b_day_date, @b_day_month, @b_day_year = "", "", ""
    attributes.each do |name, value|
      send("#{name}=", value) unless name.include?("b_day") 
      @b_day_date = value if name.include?("b_day(3i)") && !value.blank?
      @b_day_month = value if name.include?("b_day(2i)") && !value.blank?
      @b_day_year = value if name.include?("b_day(1i)") && !value.blank?
    end
  end
  
  def date_format_change
    if !@b_day_date.blank? and !@b_day_month.blank? and !@b_day_year.blank?
      self.b_day = (@b_day_date+"-"+ @b_day_month+"-"+@b_day_year).to_date rescue ""
    end
  end

  def persisted?
    false
  end

  def member_uniqueness_of_email
    member_obj = member.blank? ? Member.find_by_email(email) : Member.find_by_email(email,:conditions=>["email != ? ", member.email])
    if !email.blank? and member_obj
      errors.add_to_base("Email has already been taken")
    end
  end

  def member_uniqueness_of_stash_name
    member_obj = member.blank? ? Member.find_by_stash_name(stash_name) : Member.find_by_stash_name(stash_name,:conditions=>["stash_name != ? ", member.stash_name])    
    if !stash_name.blank? and member_obj
      errors.add_to_base("Stash name has already been taken")
    end
  end

end
