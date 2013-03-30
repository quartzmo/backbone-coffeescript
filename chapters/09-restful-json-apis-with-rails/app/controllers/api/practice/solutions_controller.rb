class Api::Practice::SolutionsController < ApplicationController
  respond_to :json

  def index
    @solutions = current_user.solutions

    respond_to do |format|
      format.json { render json: @solutions }
    end
  end

  def show
    @solution = Solution.where(user_id: current_user.id).find(params[:id])

    respond_to do |format|
      format.json { render json: @solution }
    end
  end

  def create
    @solution = current_user.solutions.build(params[:solution])
    @solution.user = current_user if current_user

    respond_to do |format|
      if @solution.save
        format.json { render json: @solution, status: :created, location: ['api', 'practice', @solution] }
      else
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @solution = Solution.where(user_id: current_user.id).find(params[:id])

    respond_to do |format|
      if @solution.update_attributes(params[:solution])
        format.json { head :no_content }
      else
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @solution = Solution.where(user_id: current_user.id).find(params[:id])
    @solution.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

end