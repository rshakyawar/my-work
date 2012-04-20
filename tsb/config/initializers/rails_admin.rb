RailsAdmin.config do |config|
  config.authenticate_with {authenticate_with_admin}
  config.model MembershipCode do
    list do
      field :id do
        label "ID"
      end
      field :limit do
        label "Limit in hours"
      end
      field :value do
        label "Membership Code"
      end
      field :activated_at do
        label "activated at"
      end
      field :number_of_uses do
        label "number of uses"
      end
    end
  end

  config.model BrandPartner do
    edit do
      field :partner_name do
        label "Partner Name"
      end
      field :email do
        label "Email"
      end
      field :password do
        label "Password"
      end
      field :password_confirmation do
        label "Password confirmation"
      end
    end
  end

end


require "rails_admin/abstract_history"
module RailsAdmin
  class AbstractHistory
    def self.create_history_item(message, object, abstract_model, user) ; end
    def self.history_summaries(from, to); end
    def self.create_update_history(model, object, associations_before, associations_after, modified_associations, old_object, user); end
    def self.history_for_model(model, query, sort, sort_reverse, all, page, per_page = RailsAdmin::Config.default_items_per_page || 20); end
    def self.history_for_object(model, object, query, sort, sort_reverse); end
    def self.history_latest_summaries ; end
    def self.history_for_month(month, year); end
    def self.most_recent_history(model) ; end
    
  end
end

