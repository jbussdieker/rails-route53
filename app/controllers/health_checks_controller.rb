class HealthChecksController < ApplicationController
  # GET /health_checks
  # GET /health_checks.json
  def index
    @health_checks = HealthCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @health_checks }
    end
  end

  # GET /health_checks/sync
  # GET /health_checks/sync.json
  def sync
    HealthCheck.sync

    respond_to do |format|
      format.html { redirect_to health_checks_path }
      format.json { redirect_to health_checks_path }
    end
  end

  # GET /health_checks/1
  # GET /health_checks/1.json
  def show
    @health_check = HealthCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @health_check }
    end
  end

  # GET /health_checks/new
  # GET /health_checks/new.json
  def new
    @health_check = HealthCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @health_check }
    end
  end

  # GET /health_checks/1/edit
  def edit
    @health_check = HealthCheck.find(params[:id])
  end

  # POST /health_checks
  # POST /health_checks.json
  def create
    @health_check = HealthCheck.new(params[:health_check])

    respond_to do |format|
      if @health_check.save
        format.html { redirect_to @health_check, notice: 'Health check was successfully created.' }
        format.json { render json: @health_check, status: :created, location: @health_check }
      else
        format.html { render action: "new" }
        format.json { render json: @health_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /health_checks/1
  # PUT /health_checks/1.json
  def update
    @health_check = HealthCheck.find(params[:id])

    respond_to do |format|
      if @health_check.update_attributes(params[:health_check])
        format.html { redirect_to @health_check, notice: 'Health check was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @health_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_checks/1
  # DELETE /health_checks/1.json
  def destroy
    @health_check = HealthCheck.find(params[:id])
    @health_check.destroy

    respond_to do |format|
      format.html { redirect_to health_checks_url }
      format.json { head :no_content }
    end
  end
end
