class Api::Practice::ExercisesController < ApplicationController
  respond_to :json

  # GET /exercises
  # GET /exercises.json
  def index
    @exercises = Exercise.all

    respond_to do |format|
      format.json { render json: @exercises }
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/new
  # GET /exercises/new.json
  def new
    @exercise = Exercise.new

    respond_to do |format|
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = Exercise.new(params[:exercise])

    respond_to do |format|
      if @exercise.save
        format.json { render json: @exercise, status: :created, location: ['api', 'practice', @exercise] }
      else
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  def update
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        format.json { head :no_content }
      else
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
