class MemberController < ApplicationController
  layout "application"

  def forgot_stash_name;  end

  def send_forgot_stash_name
    if params[:userEmail] == params[:confirmEmail] && validate_email(params[:userEmail])
   		member = Member.find_by_email(params[:userEmail])
   		unless member.blank?
	   		UserMailer.send_mail_for_forgot_stashname(member).deliver!
  	 		flash[:notice]="You information is on its way!"
    	else
     		flash[:notice]="Email does not exist."
    	end
  	else
  		flash[:notice]="Please Enter valid Email ."
    end
    render :action=>"forgot_stash_name"
  end
  
end
