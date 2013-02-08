class Api::Practice::ScoresController < ApplicationController
  respond_to :json

  def show
    @score = Score.where(user_id: current_user.id).find(params[:id])

    respond_to do |format|
      format.json { render json: @score }
    end
  end

  def create
    @score = current_user.scores.build(params[:score])
    @score.user = current_user if current_user

    respond_to do |format|
      if @score.save
        format.json { render json: @score, status: :created, location: ['api', 'practice', @score] }
      else
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @score = Score.where(user_id: current_user.id).find(params[:id])

    respond_to do |format|
      if @score.update_attributes(params[:score])
        format.json { head :no_content }
      else
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @score = Score.where(user_id: current_user.id).find(params[:id])
    @score.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
