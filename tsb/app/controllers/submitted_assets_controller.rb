class SubmittedAssetsController < ApplicationController
  # GET /submitted_assets
  # GET /submitted_assets.xml
  def index
    @submitted_assets = SubmittedAsset.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submitted_assets }
    end
  end

  # GET /submitted_assets/1
  # GET /submitted_assets/1.xml
  def show
    @submitted_asset = SubmittedAsset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submitted_asset }
    end
  end

  # GET /submitted_assets/new
  # GET /submitted_assets/new.xml
  def new
    @submitted_asset = SubmittedAsset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submitted_asset }
    end
  end

  # GET /submitted_assets/1/edit
  def edit
    @submitted_asset = SubmittedAsset.find(params[:id])
  end

  # POST /submitted_assets
  # POST /submitted_assets.xml
  def create
    @submitted_asset = SubmittedAsset.new(params[:submitted_asset])

    respond_to do |format|
      if @submitted_asset.save
        format.html {
          flash[:notice] = "Thanks! Check your inbox!"
          redirect_to root_url
        }
        format.xml  { render :xml => @submitted_asset, :status => :created, :location => @submitted_asset }
      else
        format.html {
          flash[:error] = @submitted_asset.errors.full_messages
          redirect_to root_url
        }
        format.xml  { render :xml => @submitted_asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /submitted_assets/1
  # PUT /submitted_assets/1.xml
  def update
    @submitted_asset = SubmittedAsset.find(params[:id])

    respond_to do |format|
      if @submitted_asset.update_attributes(params[:submitted_asset])
        format.html { redirect_to(@submitted_asset, :notice => 'SubmittedAsset was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @submitted_asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /submitted_assets/1
  # DELETE /submitted_assets/1.xml
  def destroy
    @submitted_asset = SubmittedAsset.find(params[:id])
    @submitted_asset.destroy

    respond_to do |format|
      format.html { redirect_to(submitted_assets_url) }
      format.xml  { head :ok }
    end
  end
end

