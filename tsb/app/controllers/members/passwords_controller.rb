class Members::PasswordsController < Devise::PasswordsController
  layout "application"
  before_filter :set_params ,:only=>[:create]

  private
  def set_params
    member = Member.find_by_stash_name(params[:member][:stash_name])
    if member.nil?
      params[:member] = {"email"=>"nil"}
    else
      params[:member] = {"email"=>member.email}
    end
  end

end