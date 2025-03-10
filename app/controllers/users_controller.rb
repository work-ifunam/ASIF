class UsersController < ApplicationController

  before_filter :require_user
  load_and_authorize_resource

  def index
    #if current_user.category == "Chuck Norris"
    if current_user.category == "Chuck Norris" || current_user.id == 169
      @users = User.find(:all, :order => "lastname")
      respond_to do |format|
        format.html 
        format.json { render json: @users }
      end
    else
      redirect_to :home
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        puts 'user.save controlador usuario bien'
        format.html { redirect_to action: 'index'}
        format.json { render json: @user, status: :created, location: @user }
      else
        puts 'user.save controlador usuario mal'
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to action: 'index' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
