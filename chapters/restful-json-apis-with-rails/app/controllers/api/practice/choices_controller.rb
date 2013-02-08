class Api::Practice::ChoicesController < ApplicationController
  respond_to :json

  # GET /choices
  # GET /choices.json
  def index
    @choices = Choice.all

    respond_to do |format|
      format.json { render json: @choices }
    end
  end

  # GET /choices/1
  # GET /choices/1.json
  def show
    @choice = Choice.find(params[:id])

    respond_to do |format|
      format.json { render json: @choice }
    end
  end

  # GET /choices/new
  # GET /choices/new.json
  def new
    @choice = Choice.new

    respond_to do |format|
      format.json { render json: @choice }
    end
  end

  # GET /choices/1/edit
  def edit
    @choice = Choice.find(params[:id])
  end

  # POST /choices
  # POST /choices.json
  def create
    @choice = Choice.new(params[:choice])

    respond_to do |format|
      if @choice.save
        format.json { render json: @choice, status: :created, location: ['api', 'practice', @choice] }
      else
        format.json { render json: @choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /choices/1
  # PUT /choices/1.json
  def update
    @choice = Choice.find(params[:id])

    respond_to do |format|
      if @choice.update_attributes(params[:choice])
        format.json { head :no_content }
      else
        format.json { render json: @choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /choices/1
  # DELETE /choices/1.json
  def destroy
    @choice = Choice.find(params[:id])
    @choice.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
