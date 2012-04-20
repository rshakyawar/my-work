class Question < ActiveRecord::Base

  belongs_to :product
  has_many :member_choices, :dependent=> :nullify
  has_many :member_votes
  validates_attachment_content_type :versus_left, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :versus_right, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']
  validates_attachment_content_type :question_image, :content_type =>  ['image/pjpeg','image/jpeg', 'image/jpg', 'image/x-png', 'image/png','image/gif']  
  validates_attachment_size :versus_left, :less_than => 10.megabytes
  validates_attachment_size :versus_right, :less_than => 10.megabytes
  validates_attachment_size :question_image, :less_than => 10.megabytes  
  
  has_attached_file :versus_left,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "200x200#"} , 
                    :default_url =>'/images/temp_versus-left.jpg'
                    
  has_attached_file :versus_right,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => {:medium => "200x200#"} , 
                    :default_url =>'/images/temp_versus-right.jpg'
                    
  has_attached_file :question_image,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => ":rails_env/:attachment/:id/:style/:filename",
                    :bucket => Settings.bucket_name,
                    :styles => { :medium => "614x75#",:promo_question => "760x82#"} , 
                    :default_url =>'/images/temp_Question.jpg'


  def save_update_attributes(params)
    unless params[:removed].blank?
      removed_logo = send(params[:img_block]).destroy unless params[:img_block] == "versus_question" 
      send(:question_image).destroy if removed_logo.blank?
      return save
    else
      return update_attributes(params[:question])
    end
  end
  
  def save_member_vote current_versus_member, params_member_vote
    member_vote = member_votes.where(:member_id => current_versus_member.id)
    if member_vote.blank?
      member_votes.create(:selected_option=>params_member_vote,:member_id=>current_versus_member.id)
    else
      member_vote[0].selected_option = params_member_vote
      member_vote[0].save
    end
  end

end

RailsAdmin.config do |config|
  config.model Question do
      list do
        field :question_image do
          thumb_method :medium
          label "Question image"
        end
        field :question_no do
          label "Question Number"
        end
        field :current_promo_versus do
          label "Current Promo Versus"
        end
        field :member_count do
          label "Number of clicks"
        end
      end

      show do
        field :title do
          label "Question text"
        end
        field :question_no do
          label "Question Number"
        end
        field :current_promo_versus do
          label "Current Promo Versus"
        end
        field :versus_left do
          thumb_method :medium
          label "versus left image"
        end
        field :versus_right do
          thumb_method :medium
          label "versus right image"
        end
        field :member_count do
          label "Number of clicks"
        end
      end

      edit do
        field :current_promo_versus do 
          label "Current Promo Versus"
        end
        field :question_no do
          label "Question Number"
        end
        field :versus_left do
          thumb_method :medium # for images. Will default to full size image, which might break the layout
        end
        field :versus_right do
          thumb_method :medium # for images. Will default to full size image, which might break the layout
        end
        field :title do
          label "Question text"
        end
        field :member_count do
          label "Number of clicks"
        end
      end
  end
end
