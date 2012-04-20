class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    true
  end

  def authorized_user
    true
  end

  def authenticate_with_admin
    redirect_to admins_login_path and return unless current_stash_admin?
  end

  def current_stash_admin?
    session[:admin_session].blank? ? false : true
  end
  
  def validate_email(email)
	   email_regex = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
    (email =~ email_regex)		
  end
  
  def after_sign_in_path_for(resource_or_scope)
    unless params[:versus_member].blank?
      members_versus_question_path(:question_no=>1)
    else
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      home_path = "#{scope}_root_path"
      respond_to?(home_path, true) ? send(home_path) : root_path
    end
  end

end
