class AdminsController < ApplicationController
  layout "devise_layout"

  def login
    session[:admin_session] = nil
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by_name(params[:admin][:name])
    if @admin and @admin.admin_password.to_s == params[:admin][:admin_password]
      session[:admin_session] = @admin
      redirect_to rails_admin_dashboard_path
    else
      session[:admin_session] = nil
      flash[:notice] = "The username or password you entered is incorrect."
      render admins_login_path
    end
  end

end