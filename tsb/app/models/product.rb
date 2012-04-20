class Product < ActiveRecord::Base
  BLOCK_IMAGE_NAME = {"logo_one"=>"logo_one", "logo_two"=>"logo_two", "top_banner"=>"top_banner" ,"bottom_banner"=>"bottom_banner" ,"background"=>"background","versus_left"=>"versus_left","versus_right"=>"versus_right","versus_question"=>"versus_question"}
  validates_attachment_content_type :logo_one, :content_type => ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :logo_two, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :top_banner, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :bottom_banner, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :background, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']

  validates_attachment_size :logo_one, :less_than => 10.megabytes
  validates_attachment_size :logo_two, :less_than => 10.megabytes
  validates_attachment_size :top_banner, :less_than => 10.megabytes
  validates_attachment_size :bottom_banner, :less_than => 10.megabytes
  validates_attachment_size :background, :less_than => 10.megabytes

  has_attached_file :logo_one,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "172x75#"} , 
                    :default_url =>'/images/1.gif'
  has_attached_file :logo_two,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "120x55#"} , 
                    :default_url =>'/images/5.gif'
                   
 has_attached_file :top_banner,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "614x75#",:promo_top_banner => "760x75#"} , 
                    :default_url =>'/images/temp_top_banner.jpg'
                    
  has_attached_file :bottom_banner,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "614x75#"}

  has_attached_file :background,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "616x271#",:promo_background => "760x300#"} , 
                    :default_url =>'/images/temp_background.jpg'
                    
                    
  has_attached_file :versus_left, :styles => { :medium => "200x200#"}, :default_url =>'/images/3.gif'
  has_attached_file :versus_right, :styles => { :medium => "200x200#"}, :default_url =>'/images/4.gif'
  
  
  
  has_many :questions, :dependent=>:destroy
  belongs_to :versus

  def save_update_attributes(params)
    unless params[:removed].blank?
      send(params[:img_block]).destroy
      return save
    else
      return update_attributes(params[:product])
    end
  end

  def self.save_question(product,params,versus)
    if product
      @questions = product.questions
      if !@questions.blank? and (question = @questions.find_by_question_no(params[:question][:question_no]))
        question.save_update_attributes(params)
      else
        product.questions.create(params[:question])
      end
    else
      @product = versus.build_product
      @product.save
      @product.questions.create(params[:question])
    end
  end

end

