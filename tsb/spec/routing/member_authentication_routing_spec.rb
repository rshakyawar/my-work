require "spec_helper"

describe Members::MemberAuthenticationController do
  describe "routing" do
    it "recognizes and generates #the_deal_live" do
      get("/the_deal_live").should route_to("Members::MemberAuthentication#the_deal_live")
    end
    
    it "recognizes and generates #the_deal_live" do
      {:get=> '/members/versus_question/1'}.should route_to(:controller=>"members/member_authentication", :action=>"home", :question_no=>1)
    end
    
  end
end
