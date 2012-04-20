class Steal < ActiveRecord::Base
  belongs_to :versus
  validates_attachment_content_type :steal_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_size :steal_image, :less_than => 10.megabytes
  has_attached_file :steal_image, :styles => { :medium => "237x212#"}
  
  has_attached_file :steal_image,
                :storage => :s3,
                :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                :path => ":rails_env/:attachment/:id/:style/:filename",
                :bucket => Settings.bucket_name,
                :styles => { :medium => "237x212#",:steal => "290x270#"}, 
                :default_url =>'/images/the_steal_big.jpg' 

  def save_update_attributes(params)
    unless params[:removed].blank?
      steal_image.destroy
      save
    end
    return update_attributes(params[:steal])
  end
end

