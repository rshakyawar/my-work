# this controller's code is not restful, need to improve  
class BrandPartners::VersusController < ApplicationController
  layout "devise_layout"
  before_filter :authenticate_brand_partner!
  before_filter :selected_tab, :only=>[:show_versus, :question]
  before_filter :current_versus, :only=>[:new_versus, :save_versus_page, :show_versus, :versus_question, :save_versus_question, :question]
  before_filter :set_session_question, :only=>[:versus_question]

  def new
    @versus = Versus.new
  end

  def create_versus
    @versus = Versus.new(params[:versus])
    @versus.brand_partner_id = current_brand_partner.id
    if @versus.save
      set_session_question
      redirect_to :action=>"show_versus",:versus_id=>@versus.id,:img_block=>Product::BLOCK_IMAGE_NAME["top_banner"]
    else
      flash[:notice] = "Please enter valid value!"
      render :action=>:new
    end
  end

  def my_versus
    @select_versus = if !params[:versus].nil? and !params[:versus][:id].nil?
      current_brand_partner.versuses.find(params[:versus][:id])
    else
      current_brand_partner.versuses.first
    end
    redirect_to :action=>:new if @select_versus.nil?
  end

  def update_versus_detail
    @select_versus = current_brand_partner.versuses.find(params[:versus][:id])
    if @select_versus.update_attributes(params[:versus])
      set_session_question
      redirect_to :action=>"show_versus",:versus_id=>@select_versus.id,:img_block=>Product::BLOCK_IMAGE_NAME["top_banner"]
    else 
      render :action=>:my_versus
    end
  end

  def save_versus_page
    if @versus.product
      @versus.product.save_update_attributes(params)
    else
      @versus.build_product(params[:product])
      @versus.save
    end
    redirect_to :action => :show_versus , :img_block=>params[:img_block], :versus_id=>@versus.id
  end

  def show_versus
    @product = @versus.product || @versus.build_product
    get_question
    render :layout=>"partner_show_versus",:action=>:new_versus
  end

  def versus_question
    redirect_to :action=>"show_versus",:versus_id=>@versus.id,:img_block=>Product::BLOCK_IMAGE_NAME["top_banner"] and return if  check_question_limit(params[:question_no])
    @selected_tab = Product::BLOCK_IMAGE_NAME["versus_question"]
    @product = @versus.product || @versus.build_product
    @question = @product.questions.find_by_question_no(params[:question_no]) || @product.questions.build
    render :layout=>"partner_versus_question"
  end

  def save_versus_question
    redirect_to :action=>"show_versus",:versus_id=>@versus.id,:img_block=>Product::BLOCK_IMAGE_NAME["top_banner"] and return if check_question_limit(params[:question][:question_no])
    Product.save_question(@versus.product,params,@versus)
    redirect_to :action=>:versus_question, :versus_id=>@versus.id, :question_no=>params[:question][:question_no] and return if params[:img_block] == "versus_question"
    redirect_to :action=>:question, :versus_id=>@versus.id, :question_no=>params[:question][:question_no], :img_block=>params[:img_block] and return unless params[:img_block].blank?
  end

  def question
    @product = @versus.product || @versus.build_product
    get_question
    render :layout=>"partner_versus_question_left_right"
  end

  private
  
  def current_versus
    @versus = current_brand_partner.versuses.find(params[:versus_id])
  end

  def selected_tab
    img_block = params[:img_block]
    @selected_tab = img_block.blank? ?  Product::BLOCK_IMAGE_NAME["top_banner"] : ( Product::BLOCK_IMAGE_NAME[img_block].blank? ? Product::BLOCK_IMAGE_NAME["top_banner"] : Product::BLOCK_IMAGE_NAME[img_block] )
  end

  def get_question
    @question = @product.questions.find_by_question_no(session_question) || @product.questions.build
  end

  def session_question
    session[:current_question] || 1
  end

  def set_session_question
    session[:current_question] =  (params[:question_no].blank? ? 1 : params[:question_no])
  end

  def check_question_limit(no_of_question)
   return true if no_of_question.to_i > @versus.no_of_questions or ![1,2,3].include?(no_of_question.to_i)
   return false
  end
end
