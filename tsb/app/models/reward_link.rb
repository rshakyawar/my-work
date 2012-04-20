class RewardLink < ActiveRecord::Base
  belongs_to :versus
  
  validates_attachment_content_type :deal_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg','image/png', 'image/x-png','image/gif']
  validates_attachment_size :deal_image, :less_than => 10.megabytes
  has_attached_file :deal_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "180x170#",:thank_you_deal=>"197x223#"} , 
                    :default_url =>'/images/the_deal.jpg'

  validates_attachment_content_type :steal_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :steal_image, :less_than => 10.megabytes
  has_attached_file :steal_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "180x170#",:thank_you_steal=>"221x214#"} , 
                    :default_url =>'/images/the_steal.jpg'
  
  validates_attachment_content_type :schwag_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :schwag_image, :less_than => 10.megabytes
  has_attached_file :schwag_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "180x170#",:thank_you_schwag=>"221x214#"} , 
                    :default_url =>'/images/the_schwag.jpg'

  def save_update_attributes(params)
    unless params[:removed].blank?
      send(params[:img_block]).destroy
      save
    end
    return update_attributes(params[:reward_link])
  end
  
end
