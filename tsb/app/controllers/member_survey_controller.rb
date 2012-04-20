class MemberSurveyController < ApplicationController

  before_filter :validate_temp_session, :only=>[:survey_two, :create_survey_two, :survey_three,:create_member_profile, :create_member_and_survey_three,:member_profile,:create_member_profile, :create_survey_one, :update_survey_one,:update_survey,:create_member_profile]
  before_filter :before_survey_one, :only=>[:survey_one,:survey]
  before_filter :destroy_temp_session, :only=>[:have_code, :do_not_have_code]
  before_filter :validate_presence_of_survey_one, :only=>[:survey_two, :create_survey_two]
  before_filter :validate_absence_of_survey_two, :only=>[:survey_two, :create_survey_two]
  before_filter :validate_presence_of_survey_two, :only=>[:survey_three, :create_member_and_survey_three ]
  before_filter :validate_absence_of_survey_three, :only=>[:survey_three, :create_member_and_survey_three]
  before_filter :validate_presence_of_survey_one_two_three, :only=>[:member_profile,:create_member_profile]  
  
  def have_code
    redirect_to membership_path
  end
  def do_not_have_code; end
  def bad_membership_code; end

  def submit_code
    membership_code = MembershipCode.find_by_value(params[:membership_code].to_s)
    if membership_code.blank? or !membership_code.validate_membership_code
      render :json =>"Please enter valid code".to_json, :status => :unprocessable_entity
    else
      member = membership_code.members.create(:temp_session_id=>generate_session_token)
      session[:temp_session_id] = member.temp_session_id
      render :json =>"true".to_json, :status => :created
    end
  end

  def survey
  end # We have already @member object
  
  def update_survey
    if @member.update_attributes(params[:member])
      redirect_to member_survey_member_profile_path
    else
      render member_survey_survey_path
    end
  end
  
    
  def member_profile
    @member_form = MemberForm.new  
  end
  
  
  def create_member_profile
    @validate_member_form = MemberForm.new(params[:member_form])
    @member_form = @validate_member_form
    if @validate_member_form.valid?
      @member.update_attributes(params[:member_form])
      @member.activate_member
      @member.membership_code.save_number_of_uses if !@member.membership_code.blank? and !@member.membership_code.number_of_uses.nil?
      session[:temp_session_id] = nil
      if @member.membership_code_id.blank?
        @member.send_thank_you_email
        redirect_to member_survey_thanks_path and return
      else
        @member.send_congrats_email
        redirect_to member_survey_congrats_path and return
      end
    else
      render member_survey_member_profile_path and return
    end
  end
  
  def survey_one
    @member_survey_one = @member.member_survey_one || MemberSurveyOne.new
    @member_survey_two = MemberSurveyTwo.new    
    @member_survey_three = MemberSurveyThree.new    
  end

# Post
  def create_survey_one  
    @member_survey_one = @member.build_member_survey_one(params[:member_survey_one])
    if @member_survey_one.save
      redirect_to member_survey_survey_two_path
    else
      render member_survey_survey_path
    end
  end

#Put
  def update_survey_one
    @member_survey_one = @member.member_survey_one     
    if @member_survey_one.update_attributes(MemberSurveyOne::ATTRIBUTES.merge!(params[:member_survey_one] || {}))
      redirect_to member_survey_survey_two_path
    else
      render member_survey_survey_path
    end
  end

  def survey_two
    @member_survey_two = MemberSurveyTwo.new
  end

  def create_survey_two
    @member_survey_two = @member.build_member_survey_two(params[:member_survey_two])
    if @member_survey_two.save
      redirect_to member_survey_survey_three_path
    else
      render member_survey_survey_two_path
    end
  end

  def survey_three
    @member_survey_three = MemberSurveyThree.new
    @member_form = MemberForm.new
  end

  def create_member_and_survey_three
    @member_survey_three = @member.build_member_survey_three(params[:member_survey_three])
    @member_form = MemberForm.new(params[:member_form])
    if @member_form.valid? and @member_survey_three.save
      @member.update_attributes(params[:member_form])
      @member.activate_member
      @member.membership_code.save_number_of_uses if !@member.membership_code.blank? and !@member.membership_code.number_of_uses.nil?
      session[:temp_session_id] = nil
      if @member.membership_code_id.blank?
        @member.send_thank_you_email
        redirect_to member_survey_thanks_path and return
      else
        @member.send_congrats_email
        redirect_to member_survey_congrats_path and return
      end
    else
      render member_survey_survey_three_path and return
    end
  end

  def thanks;  end
  def congrats;  end

  private

  def validate_temp_session
    @member = Member.find_by_temp_session_id(session[:temp_session_id].to_s)
    redirect_to membership_path and return if @member.blank?
  end

  def before_survey_one
    if session[:temp_session_id].blank?
      @member = Member.new(:temp_session_id=>generate_session_token)
      @member.save
      session[:temp_session_id] = @member.temp_session_id
    else
      @member = Member.find_by_temp_session_id(session[:temp_session_id].to_s)
      redirect_to membership_path and return if @member.blank?
    end
  end

  def generate_session_token
    (Digest::MD5.hexdigest "#{ActiveSupport::SecureRandom.hex(10)}-#{DateTime.now.to_s}")
  end

  def destroy_temp_session
    session[:temp_session_id] = nil
  end
  
  def validate_presence_of_survey_one
    redirect_to membership_path and return if @member.member_survey_one.nil?
  end

  def validate_absence_of_survey_two
    redirect_to membership_path and return unless @member.member_survey_two.nil?
  end

  def validate_absence_of_survey_three
    redirect_to membership_path and return unless @member.member_survey_three.nil?
  end

  def validate_presence_of_survey_two
    redirect_to membership_path and return if @member.member_survey_one.nil?
    redirect_to membership_path and return if @member.member_survey_two.nil?
  end
  
  def validate_presence_of_survey_one_two_three
    redirect_to membership_path and return if @member.member_survey_one.nil? or @member.member_survey_two.nil? or @member.member_survey_three.nil?
  end
end
