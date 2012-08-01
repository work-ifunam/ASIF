class CategoriesController < ApplicationController

  before_filter :require_user
  load_and_authorize_resource

  def index
    @categories_assignations = Category.assignation(current_user.category);
    respond_to do |format|
      format.html 
      format.json { render json: @categories }
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html 
      format.json { render json: @category }
    end
  end

  def create
    @category = Category.new(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to action: "index" }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @category = Category.find(params[:id])
     @category.destroy
     respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
   end

end
