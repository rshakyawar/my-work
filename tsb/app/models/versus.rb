class Versus < ActiveRecord::Base
  validates_format_of :contact_email, :with => /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
  validates :contact_name, :detail, :presence => true
  validates_inclusion_of :no_of_questions, :in => [1, 2, 3]
  belongs_to :brand_partner
  has_one :product, :dependent=>:destroy
  has_one :reward_link, :dependent=>:destroy
  has_one :deal, :dependent=>:destroy
  has_one :steal, :dependent=>:destroy
  has_one :schwag, :dependent=>:destroy
  has_one :schwag_magic_number, :dependent=>:destroy
  has_many :schwag_shots, :dependent=>:destroy
  has_many :schwag_winners, :dependent=>:destroy
  has_many :questions, :through=>:product
  has_one :popup_sending_text, :dependent=>:destroy
  has_one :shwag_winner_looser_popup, :dependent=>:destroy
  
  def self.live_promo_versus
    self.find_by_live_versus(1)
  end
  
  def schwag_magic_numbers
    schwag_magic_number_obj = self.schwag_magic_number
    if schwag_magic_number_obj.blank?
      return ""
    else
      return schwag_magic_number_obj.magic_numbers
    end
  end
  
  def update_schwag_magic_number(shot_number)
    schwag_magic_number_obj = self.schwag_magic_number
    magic_numbers = schwag_magic_number_obj.magic_numbers
    schwag_magic_number_obj.magic_numbers = magic_numbers.gsub("@@" + shot_number.to_s + "--", "")
    return true if schwag_magic_number_obj.save
    return false
  end
  
  def success_schwag_shot(member,  shot_number)
    schwag_shot_obj = self.schwag_shots.find_by_member_id(member.id)
    unless schwag_shot_obj.blank?
      #schwag_shot_obj.shot_count = schwag_shot_obj.shot_count.to_i + 1
      #schwag_shot_obj.ready_to_next_question = true
      #schwag_shot_obj.fb_twit_token = nil
      #schwag_shot_obj.save
      schwag_shot_obj.update_attributes(:shot_count=>schwag_shot_obj.shot_count.to_i + 1,:ready_to_next_question=>true,:fb_twit_token=>nil) 
    else
      self.schwag_shots.create(:member_id =>member.id, :shot_count => 1, :ready_to_next_question=> true, :fb_twit_token => nil)
    end
  end
  
  def failure_schwag_shot(member, shot_number)
    schwag_shot_obj = self.schwag_shots.find_by_member_id(member.id)
    token = ActiveSupport::SecureRandom.hex(4)
    unless schwag_shot_obj.blank?
      #schwag_shot_obj.shot_count = schwag_shot_obj.shot_count.to_i + 1
      #schwag_shot_obj.ready_to_next_question = false
      #schwag_shot_obj.fb_twit_token = token
      #schwag_shot_obj.save
      schwag_shot_obj.update_attributes(:shot_count=>schwag_shot_obj.shot_count.to_i + 1,:ready_to_next_question=>false,:fb_twit_token=>token)       
    else
      self.schwag_shots.create(:member_id =>member.id, :shot_count => 1, :ready_to_next_question=> false, :fb_twit_token => token)
    end    
  end
  
  def save_schwag_magic_number magic_numbers
    unless schwag_magic_number
      build_schwag_magic_number(:magic_numbers=>magic_numbers).save rescue ""
    else
      schwag_magic_number.update_attributes(:magic_numbers=>magic_numbers) rescue ""
    end
  end
  
end

RailsAdmin.config do |config|
  config.model Versus do
    edit do
      field :contact_name
      field :contact_email
      field :detail
      field :live_versus
    end
   list do
      field :contact_name
      field :contact_email
      field :detail
      field :live_versus
    end
    show do
      field :contact_name
      field :contact_email
      field :detail
      field :live_versus
    end
  end
end
