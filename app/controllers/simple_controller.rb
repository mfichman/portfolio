class SimpleController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  helper_method :record_class

  BATCH_SIZE = 10

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
      format.html { redirect_to record_class, notice: "#{record_class.model_name.singular.humanize} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /records/batch/new
  # GET /records/batch/new.json
  def batch_new
    @records = Array.new(BATCH_SIZE) { record_class.new }
  end

  # GET /records/batch/edit
  # GET /records/batch/edit.json
  def batch_edit
    @records = record_class.all
  end

  # POST /records/batch
  # POST /records/batch.json
  def batch_create
    @values = record_batch_params.values.reject { |p| p.values.all?(&:blank?) }
    @records = record_class.create(@values)

    respond_to do |format|
      if @records.all?(&:valid?)
        format.html { redirect_to url_for(action: 'index'), notice: "#{record_class.model_name.plural.humanize} were successfully created." }
        format.json { render :index, status: :created }
      else
        @records = @records.fill(@records.size..BATCH_SIZE) { record_class.new }

        format.html { render :batch_new }
        format.json { render json: @records.map(&:errors), status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/batch
  # PUT /records/batch.json
  def batch_update
    @records = record_class.update(record_batch_params.keys, record_batch_params.values)

    respond_to do |format|
      if @records.all?(&:valid?)
        format.html { redirect_to url_for(action: 'index'), notice: "#{record_class.model_name.plural.humanize} were successfully updated." }
        format.json { render :index, status: :ok }
      else
        format.html { render :batch_edit }
        format.json { render json: @records.map(&:errors), status: :unprocessable_entity }
      end
    end
  end

  class << self
    attr_accessor :permitted_params
  end

  private

  def save_batch
    saved = ActiveRecord::Base.transaction do
      saved = record_batch_params.map.with_index do |p, index|
        if p.second.values.all?(&:blank?)
          true
        else
          @records[index].save
        end
      end

      raise ActiveRecord::Rollback unless saved.all?

      true
    end
  end

  def set_record
    @record = record_class.find(params[:id])
  end

  def record_class
    controller_name.singularize.camelize.constantize
  end

  def record_params
    params.require(record_class.model_name.singular).permit(self.class.permitted_params)
  end

  def record_batch_params
    params.permit(record_class.model_name.plural => self.class.permitted_params).fetch(record_class.model_name.plural, {})
  end
end
