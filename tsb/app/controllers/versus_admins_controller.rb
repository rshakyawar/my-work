class VersusAdminsController < ApplicationController

 before_filter :authenticate_with_admin, :only=>[:update_versus]

 def update_versus
   @versus = Versus.find(params[:id])
   if @versus.update_attributes(params[:versus])
     redirect_to "/admin/versus"
   else
     redirect_to "/admin/versus"
   end
 end
end
