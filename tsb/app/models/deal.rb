class Deal < ActiveRecord::Base
  belongs_to :versus
  validates_attachment_content_type :deal_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg','image/png', 'image/x-png','image/gif']
  validates_attachment_size :deal_image, :less_than => 10.megabytes
  has_attached_file :deal_image, :styles => { :medium => "237x212#"}
  
  has_attached_file :deal_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "237x212#"}  

  def save_update_attributes(params)
    unless params[:removed].blank?
      deal_image.destroy
      save
    end
    return update_attributes(params[:deal])
  end

end


