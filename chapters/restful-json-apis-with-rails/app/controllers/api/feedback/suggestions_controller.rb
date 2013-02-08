class Api::Feedback::SuggestionsController < ApplicationController
  respond_to :json

  def index
    @suggestions = Suggestion.order('created_at desc').limit(5)

    respond_to do |format|
      format.json { render json: @suggestions.to_json(only: [:id, :subject, :message]) }
    end
  end

  def show
    @suggestion = Suggestion.find(params[:id])
    respond_with @suggestion
  end

  def new
    @suggestion = Suggestion.new
    respond_with @suggestion
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
    respond_with @suggestion
  end

  def create
    @suggestion           = Suggestion.new(params[:suggestion])
    respond_to do |format|
      if @suggestion.save
        format.json { render json: @suggestion, status: :created, location: ['api', 'feedback', @suggestion] }
      else
        format.json { render json: {errors: @suggestion.errors.full_messages}, status: :unprocessable_entity }
      end
    end

  end

  def update
    @suggestion = Suggestion.find(params[:id])
    @suggestion.update_attributes(params[:suggestion])
    respond_with @suggestion
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy
    respond_with @suggestion
  end

end
