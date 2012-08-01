class AssignationsController < ApplicationController
  
  before_filter :require_user
  load_and_authorize_resource
  
  def index
    @assignation_user = Assignation.user(current_user.category);
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignations }
    end
  end
  
  def new
    @assignation = Assignation.new
    @category = Category.assignation(current_user.category);
    @user = User.assignation(current_user.category);
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignation }
    end
  end
  
  def create
    @assignation = Assignation.new(params[:assignation])
    respond_to do |format|
      if @assignation.save
        format.html { redirect_to action: "index" }
        format.json { render json: @assignation, status: :created, location: @assignation }
      else
        format.html { render action: "new" }
        format.json { render json: @assignation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @assignation = Assignation.find(params[:id])
   # @category = Category.assignation(current_user.category);
   # @user = User.assignation(current_user.category);
    @assignation.destroy
    respond_to do |format|
      format.html { redirect_to assignations_url }
      format.json { head :no_content }
    end
  end
end
