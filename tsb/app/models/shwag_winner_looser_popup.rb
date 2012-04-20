class ShwagWinnerLooserPopup < ActiveRecord::Base
  belongs_to :versus
  
  validates_attachment_content_type :real, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :real, :less_than => 10.megabytes
  has_attached_file :real,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "196x254#"} , 
                    :default_url =>'/images/real_logo.jpg'  
                    
  validates_attachment_content_type :looser, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :looser, :less_than => 10.megabytes
  has_attached_file :looser,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "171x184#"} , 
                    :default_url =>'/images/looser_logo.jpg' 
                     
  validates_attachment_content_type :winner, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :winner, :less_than => 10.megabytes
  has_attached_file :winner,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "171x184#"} , 
                    :default_url =>'/images/winner_logo.jpg'
                    
  validates_attachment_content_type :fb_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :fb_image, :less_than => 10.megabytes
  has_attached_file :fb_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "90x40#"} , 
                    :default_url =>'/images/fb_logo.jpg'                    
  
  def save_update_attributes(params)
    unless params[:removed].blank?
      send(params[:img_block]).destroy
      save
    end
    return update_attributes(params[:shwag_winner_looser_popup])
  end                    
                                                              
end
