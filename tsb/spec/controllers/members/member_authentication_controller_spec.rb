require 'spec_helper'

describe Members::MemberAuthenticationController do

  describe "GET #home" do
    it "should be go to thank_you_page" do
      get 'home', :question_no=>1
      response.should redirect_to('versus_members/sign_in')
    end
  end 
    
end
