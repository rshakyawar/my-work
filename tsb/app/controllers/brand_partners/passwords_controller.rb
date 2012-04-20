class BrandPartners::PasswordsController < Devise::PasswordsController
  layout "devise_layout"
  before_filter :set_params ,:only=>[:create]

  private
  def set_params
    brand_partner = BrandPartner.find(:first,:conditions=>["partner_name = ? ",params[:brand_partner][:partner_name]])
    if brand_partner.nil?
      params[:brand_partner] = {"email"=>"nil"}
    else
      params[:brand_partner] = {"email"=>brand_partner.email}
    end
  end

end
