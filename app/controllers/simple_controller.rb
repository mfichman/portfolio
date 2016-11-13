class SimpleController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  helper_method :record_class

  # GET /records
  # GET /records.json
  def index
    @records = record_class.all
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = record_class.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = record_class.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: "#{record_class.model_name.singular.humanize} was successfully created." }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: "#{record_class.model_name.singular.humanize} was successfully updated." }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_class, notice: "#{record_class.model_name.singular.humanize} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  class << self
    attr_accessor :permitted_params
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = record_class.find(params[:id])
  end

  def record_class
    controller_name.singularize.camelize.constantize
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(record_class.model_name.singular).permit(self.class.permitted_params)
  end
end
