class Members::MemberController < ApplicationController
  layout "application"
  before_filter :member_should_have_code

  def home ; end

  def profile
    @member, @member_form = current_member, current_member
    render member_survey_member_profile_path
  end

  def update_profile
    @member = current_member
    @validate_member_form = MemberForm.new(params[:member_form] || params[:member])
    @validate_member_form.member = current_member
    if @validate_member_form.valid?
      attributes = (params[:member_form] || params[:member])
      @member.update_attributes(attributes)
      sign_in @member, :bypass => true
      sign_in :versus_member, @member, :bypass => true
      redirect_to member_root_path, :notice =>"Member was successfully updated."
    else
      @member_form =  current_member
      @member_form.attributes = (params[:member_form] || params[:member])
      render member_survey_member_profile_path
    end
  end

  def invite_friends
    @member = current_member
    @exist_invite_friends = @member.invite_friends.size
    (InviteFriend::FRIENDS_SIZE - @member.invite_friends.size).times{ @member.invite_friends.build }
  end

  def send_mail_for_invite_friend
    @invite_friend = current_member.invite_friends.build(params[:invite_friend])
    if @invite_friend.save
      render :json =>"Email has been send".to_json, :status => :created
    else
      render :json =>@invite_friend.errors, :status => :unprocessable_entity
    end
  end

  private
 
    def member_should_have_code
      authenticate_member!
      unless current_member.active?
        sign_out current_member
        redirect_to members_login_path and return
      end
    end

end
