module SiteHelper

  def set_activate_tab selected_tab, input
    return "active" if selected_tab == input
  end

end
