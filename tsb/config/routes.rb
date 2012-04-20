Stashbox::Application.routes.draw do

  devise_for :brand_partners, :controllers => {:sessions => "brand_partners/sessions",:registrations =>"brand_partners/registrations" ,:passwords => "brand_partners/passwords"}
  devise_for :members, :controllers => {:sessions => "members/sessions",:passwords => "members/passwords"}
  devise_for :versus_members, :class_name => 'Member', :controllers => {:sessions => "versus_members/sessions"}, :only => :sessions do 
    match "/" => "VersusMembers::Sessions#new"
  end
  match '/brand_partner' => "BrandPartners::Versus#new", :as => :brand_partner_root
  match '/members/home' => "Members::Member#home", :as => :member_root
  match '/members/profile' => "Members::Member#profile"
  match '/members/invite_friends' => "Members::Member#invite_friends"
  match '/members/save'=> "Members::Member#update_profile", :via => :put
  match '/members/send_mail_for_invite_friend' => "Members::Member#send_mail_for_invite_friend" ,:via=>[:post]
  match '/members/forgot_stash_name' => "Member#forgot_stash_name"
  match '/members/send_forgot_stash_name' => "Member#send_forgot_stash_name"
  match '/members/new' => "Members::MemberAuthentication#new"
  match '/members/validate_member' => "Members::MemberAuthentication#validate_member"
  match '/members/versus_question/:question_no' => 'Members::MemberAuthentication#home', :via => :get, :as=>:member_question  
  match '/members/thank_you_page'=>"Members::MemberAuthentication#thank_you_page",:via=>:get
  match '/members/the_deal' =>"Members::MemberAuthentication#the_deal_live",:via=>:get
  match '/members/the_steal' =>"Members::MemberAuthentication#the_steal_live",:via=>:get
  match '/members/the_schwag' =>"Members::MemberAuthentication#schwag_for_game",:via=>:get  
  match '/members/versus_question' => 'Members::MemberAuthentication#home', :as=>:members_versus_question
  match '/members/save_count_choice/:question_no/:member_vote' => 'Members::MemberAuthentication#save_count_choice'
  match '/members/schwag_shot/:choose_shot' => 'Members::MemberAuthentication#schwag_shot', :as=> :member_schwag_shot
  match '/members/shared_from_twitt' => 'Members::MemberAuthentication#shared_from_twitt'
  
  devise_for :partners, :controllers => {:sessions => "partners/sessions"}
  devise_for :users, :controllers => {:sessions => "users/sessions"}

  match '/admins/login'=> 'admins#login'
  match '/admins'=> 'admins#create', :via => :post
  match '/brand_partners/versus/new'=> "BrandPartners::Versus#new"
  match '/brand_partners/my_versus'=> "BrandPartners::Versus#my_versus"
  match '/brand_partners/create_versus'=> "BrandPartners::Versus#create_versus", :via => :post
  match '/brand_partners/TSB_membership_survey_step2'=> "BrandPartners::Versus#TSB_membership_survey_step2"

  match '/brand_partners/update_versus_detail'=> "BrandPartners::Versus#update_versus_detail", :via => :put

  match '/brand_partners/new_versus/:versus_id/:img_block'=> "BrandPartners::Versus#new_versus"
  match '/brand_partners/show_versus/:versus_id/:img_block'=> "BrandPartners::Versus#show_versus"
  match '/brand_partners/save_versus_page/'=> "BrandPartners::Versus#save_versus_page", :via => [:post,:put]
  match '/brand_partners/save_versus_question/'=> "BrandPartners::Versus#save_versus_question", :via => [:post,:put]
  match '/brand_partners/versus_question/:versus_id/:question_no'=> "BrandPartners::Versus#versus_question"
  match '/brand_partners/question/:versus_id/:question_no/:img_block'=> "BrandPartners::Versus#question"

  match '/brand_partners/show_deal/:versus_id'=> "BrandPartners::Reward#show_deal", :via => :get
  match '/brand_partners/show_deal/:versus_id'=> "BrandPartners::Reward#create_deal", :via => :post
  match '/brand_partners/show_deal/:versus_id'=> "BrandPartners::Reward#update_deal", :via => :put
  match '/brand_partners/show_reward_link/:versus_id/:current_link'=> "BrandPartners::Reward#show_reward_link", :via => :get
  match '/brand_partners/show_reward_link/:versus_id/:current_link'=> "BrandPartners::Reward#create_reward_link", :via => :post
  match '/brand_partners/show_reward_link/:versus_id/:current_link'=> "BrandPartners::Reward#update_reward_link", :via => :put
  match '/brand_partners/show_thank_you_popup/:versus_id/:current_link'=> "BrandPartners::Reward#show_thank_you_popup", :via => :get   
  match '/brand_partners/show_thank_you_popup/:versus_id/:current_link'=> "BrandPartners::Reward#update_thank_you_popup", :via => :put  
  match '/brand_partners/show_thank_you_popup/:versus_id/:current_link'=> "BrandPartners::Reward#create_thank_you_popup", :via => :post  
  match '/brand_partners/show_popup_sending_text/:versus_id/:current_link'=> "BrandPartners::Reward#show_popup_sending_text", :via => :get   
  match '/brand_partners/show_popup_sending_text/:versus_id/:current_link'=> "BrandPartners::Reward#update_popup_sending_text", :via => :put  
  match '/brand_partners/show_popup_sending_text/:versus_id/:current_link'=> "BrandPartners::Reward#create_popup_sending_text", :via => :post   
  match '/brand_partners/show_steal/:versus_id'=> "BrandPartners::Reward#show_steal", :via => :get
  match '/brand_partners/show_steal/:versus_id'=> "BrandPartners::Reward#create_steal", :via => :post
  match '/brand_partners/show_steal/:versus_id'=> "BrandPartners::Reward#update_steal", :via => :put
  match '/brand_partners/show_schwag/:versus_id'=> "BrandPartners::Reward#show_schwag", :via => :get
  match '/brand_partners/show_schwag/:versus_id'=> "BrandPartners::Reward#create_schwag", :via => :post
  match '/brand_partners/show_schwag/:versus_id'=> "BrandPartners::Reward#update_schwag", :via => :put
  match '/brand_partners/send_mail/:versus_id' => "BrandPartners::Reward#send_mail", :via=>:post   
  match '/brand_partners/send_multiple_mail/:versus_id' => "BrandPartners::Reward#send_multiple_mail", :via=>:post 
  match '/brand_partners/send_message/:versus_id' => "BrandPartners::Reward#send_message", :via=>:post
    
  match '/member_survey/have_code'=> "MemberSurvey#have_code"
  match '/member_survey/do_not_have_code'=> "MemberSurvey#do_not_have_code"
  match '/member_survey/submit_code'=> "MemberSurvey#submit_code", :via => :post
  match '/member_survey/survey'=> "MemberSurvey#survey"
  match '/member_survey/save_survey/:id'=> "MemberSurvey#update_survey", :via => :post, :as => :save_survey
  match '/member_survey/member_profile'=> "MemberSurvey#member_profile"  
  match '/member_survey/update_profile'=> "MemberSurvey#update_profile" , :via => :put   
  match '/member_survey/create_profile'=> "MemberSurvey#create_profile" , :via => :put   
  match '/member_survey/survey_one'=> "MemberSurvey#survey_one"
  match '/member_survey/save_survey_one'=> "MemberSurvey#update_survey_one", :via => :put
  match '/member_survey/save_survey_one'=> "MemberSurvey#create_survey_one", :via => :post
  match '/member_survey/survey_two'=> "MemberSurvey#survey_two"
  match '/member_survey/create_survey_two'=> "MemberSurvey#create_survey_two", :via => :post
  match '/member_survey/survey_three'=> "MemberSurvey#survey_three"
  match '/members/save'=> "MemberSurvey#create_member_profile", :via => :post
  match '/member_survey/thanks'=> "MemberSurvey#thanks"
  match '/member_survey/congrats'=> "MemberSurvey#congrats"
  match '/member_survey/bad_membership_code'=> "MemberSurvey#bad_membership_code"

  resources :products
  resources :subscribers
  resources :users
  resources :partners
  resources :submitted_assets

  match '/send_membership_code_to_guest' =>"guest#send_membership_code_to_guest", :as=>:send_membership_code_to_guest
  match '/brandpartners/:img_block' => 'site#brandpartners'
  match '/save_question_information' => 'site#save_question_information', :via => :post
  match '/save_button_color' => 'site#save_button_color', :via => :post
  match '/retrive_question_information'=>'site#retrive_question_information', :via => :post
  match '/forgot_user_name'=>'site#forgot_user_name'
  match '/forgot_password'=>'site#forgot_password'
  match '/give_forgot_password' => 'site#give_forgot_password', :via => :post
  match '/give_forgot_username' => 'site#give_forgot_username', :via => :post
  match '/my_versus'=>'site#my_versus'
  match '/brandpartners/' => 'site#brandpartners'
  match '/how_it_works' => 'site#how_it_works'
  match '/membership' => 'site#membership'
  match '/hunt_membership' => 'site#hunt_membership'
  match '/blog' => 'site#blog'
  match '/twitter' => 'site#twitter'
  match '/who_we_are/:tsb_gang' => 'site#who_we_are', :as=>:tsb_who_we_are
  match '/who_we_are/' => 'site#who_we_are'
  match '/contact' => "site#contact"
  match '/members_login' => 'site#members_login'
  match '/brandpartners_save' => 'site#brandpartners_save', :via => :post
  match '/tsb_join'=> 'site#index', :via => :get
  match '/tsb_privacy' => 'site#tsb_privacy'
  match '/tsb_term_of_uses' => 'site#tsb_term_of_uses'
  match '/emastrewards' => "site#emastrewards" 
  match '/thank_you_page'=>"homes#thank_you_page",:via=>:get
  match '/versus/the_deal' =>"homes#the_deal_live",:via=>:get
  match '/versus/the_steal' =>"homes#the_steal_live",:via=>:get
  match '/versus/the_schwag' =>"homes#the_schwag_live",:via=>:get
  
  match '/save_count_choice/:question_no/:member_vote' => 'homes#save_count_choice'
  #match '/your_reward/:member_selection' => 'homes#your_reward', :via => :get
  #match '/promo_staging' => 'homes#create_member_choice', :via => :post
  #match '/your_reward/:member_selection' => 'homes#create_member_choice', :via => :post
  match '/promo_staging' => 'homes#home', :via => :get
  match '/versus_question/:question_no' => 'homes#home', :via => :get, :as=>:versus_question
  match '/versus/thank_you'=>"homes#thank_you_page",:via=>:get, :as=>:versus_thank_you
  match '/admin/versus/:id'=>"versus_admins#update_versus",:via=>:put 
  match '/guest/versus_question/:question_no' => 'guest#home', :via => :get, :as=>:versus_question  
  match '/guest/thank_you_page'=>"guest#thank_you_page",:via=>:get ,:as=>:guest_thank_you
  match '/guest/save_count_choice/:question_no/:guest_vote' => 'guest#save_count_choice'
  match '/guest/save_guest_information' => 'guest#save_guest_information'
  match '/sms/send_message' => "Messagings#send_message", :via=>:get
  match '/mail/send_mail' => "Messagings#send_mail", :via=>:post   
  match '/mail/send_multiple_mail' => "Messagings#send_multiple_mail", :via=>:post 
   
  match '/messaging' => "Messagings#index", :via=>[:get,:post]   
  
  root :to => 'VersusMembers::Sessions#new'
end
