class VersusMembers::SessionsController < Devise::SessionsController
  layout "versus_member"

  before_filter :live_versus, :only=>[:new]
  
  def live_versus
    @versus = Versus.live_promo_versus
    redirect_to tsb_join_path and return if @versus.blank?
    @product = @versus.product
    redirect_to tsb_join_path and return if @product.blank?
    @questions = @versus.questions
    redirect_to tsb_join_path and return if @questions.blank?
    @question = @questions.find_by_question_no(1)
  end

  def require_no_authentication
    redirect_to members_versus_question_path(:question_no=>1) and return if versus_member_signed_in?
    if warden.authenticated?(resource_name)
      resource = warden.user(resource_name)
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to after_sign_in_path_for(resource)
    end
  end
end
