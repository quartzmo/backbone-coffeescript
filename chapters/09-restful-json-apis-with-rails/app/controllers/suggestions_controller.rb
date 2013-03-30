class SuggestionsController < ApplicationController
  
  def index
    @suggestions = Suggestion.scoped.order("created_at desc")

    respond_to do |format|
      format.html
      format.json { render json: @suggestions }
    end
  end

  def show
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      format.json { render json: @suggestion }
    end
  end

  def new
    @suggestion = Suggestion.new

    respond_to do |format|
      format.json { render json: @suggestion }
    end
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def create
    @suggestion = Suggestion.new(params[:suggestion])

    respond_to do |format|
      if @suggestion.save
        format.json { render json: @suggestion, status: :created, location: @suggestion }
      else
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.json { head :no_content }
      else
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
