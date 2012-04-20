class BrandPartners::RegistrationsController < Devise::RegistrationsController
  layout "devise_layout"

  def new
    redirect_to brand_partner_session_path
  end

  def update
  @brand_partner = current_brand_partner
    if @brand_partner.update_attributes(params[:brand_partner])
      sign_in @brand_partner, :bypass => true
      redirect_to edit_brand_partner_registration_path and return
    else
      sign_in current_brand_partner, :bypass => true
      render :action=>"edit"
    end
  end
end
