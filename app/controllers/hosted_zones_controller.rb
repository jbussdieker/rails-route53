class HostedZonesController < ApplicationController
  # GET /hosted_zones
  # GET /hosted_zones.json
  def index
    @hosted_zones = HostedZone.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hosted_zones }
    end
  end

  # GET /hosted_zones/sync
  # GET /hosted_zones/sync.json
  def sync
    HostedZone.sync

    respond_to do |format|
      format.html { redirect_to hosted_zones_path }
      format.json { redirect_to hosted_zones_path }
    end
  end

  # GET /hosted_zones/1
  # GET /hosted_zones/1.json
  def show
    @hosted_zone = HostedZone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hosted_zone }
    end
  end

  # GET /hosted_zones/new
  # GET /hosted_zones/new.json
  def new
    @hosted_zone = HostedZone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hosted_zone }
    end
  end

  # GET /hosted_zones/1/edit
  def edit
    @hosted_zone = HostedZone.find(params[:id])
  end

  # POST /hosted_zones
  # POST /hosted_zones.json
  def create
    @hosted_zone = HostedZone.new(params[:hosted_zone])

    respond_to do |format|
      if @hosted_zone.save
        format.html { redirect_to @hosted_zone, notice: 'Hosted zone was successfully created.' }
        format.json { render json: @hosted_zone, status: :created, location: @hosted_zone }
      else
        format.html { render action: "new" }
        format.json { render json: @hosted_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hosted_zones/1
  # PUT /hosted_zones/1.json
  def update
    @hosted_zone = HostedZone.find(params[:id])

    respond_to do |format|
      if @hosted_zone.update_attributes(params[:hosted_zone])
        format.html { redirect_to @hosted_zone, notice: 'Hosted zone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hosted_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosted_zones/1
  # DELETE /hosted_zones/1.json
  def destroy
    @hosted_zone = HostedZone.find(params[:id])
    @hosted_zone.destroy

    respond_to do |format|
      format.html { redirect_to hosted_zones_url }
      format.json { head :no_content }
    end
  end
end
