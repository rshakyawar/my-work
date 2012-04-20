class GenerateMembershipCode < ActiveRecord::Migration
  def self.up
  
    membership_code = Logger.new("#{Rails.root}/log/membership_code_3000.log")
    membership_code.info("############## 5 times usage codes: 3,000 ###################### ")
    (1..3000).each do |i|
      unique_membership_code = ActiveSupport::SecureRandom.hex(4)
      MembershipCode.create(:number_of_uses=>5, :value=>unique_membership_code)
      membership_code.info("#{i.to_s}: Code => #{unique_membership_code}")
    end
    
    
    membership_code = Logger.new("#{Rails.root}/log/membership_code_7_day_100.log")
    membership_code.info("############## 7 day (168 hour) expiration: 100 ###################### ")
    (1..100).each do |i|
      unique_membership_code = ActiveSupport::SecureRandom.hex(4)
      MembershipCode.create(:activated_at=>Time.now.utc + 5.5.hours, :limit=>168 , :value=>unique_membership_code)
      membership_code.info("#{i.to_s}: Code => #{unique_membership_code}")
    end
    
    
    membership_code = Logger.new("#{Rails.root}/log/membership_code_14_day_100.log")
    membership_code.info("############## 14 day (336 hour) expiration: 100 ###################### ")
    (1..100).each do |i|
      unique_membership_code = ActiveSupport::SecureRandom.hex(4)
      MembershipCode.create(:activated_at=>Time.now.utc + 5.5.hours, :limit=>336 , :value=>unique_membership_code)
      membership_code.info("#{i.to_s}: Code => #{unique_membership_code}")
    end
    
    
    membership_code = Logger.new("#{Rails.root}/log/membership_code_forever.log")
    membership_code.info("############## Can we create a set of membership codes that are live until we decide to make them inactive? I hope so: 25 ###################### ")
    (1..25).each do |i|
      unique_membership_code = ActiveSupport::SecureRandom.hex(4)
      MembershipCode.create(:number_of_uses=>50000, :value=>unique_membership_code)
      membership_code.info("#{i.to_s}: Code => #{unique_membership_code}")
    end
    
  end

  def self.down
  end
end
