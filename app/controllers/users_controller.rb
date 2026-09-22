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
  
  def autocomplete_user_name
    term = params[:term].to_s.strip
    users = User.where('firstname LIKE ? OR lastname LIKE ?', "%#{term}%", "%#{term}%").limit(20)

    results = users.map do |u|
      full_name = "#{u.firstname} #{u.lastname}".strip
      { id: u.id, label: full_name, value: full_name }
    end

    # Desactivar caché HTTP para que el navegador pida datos frescos
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
  
    render json: results, root: false
  end
 # def autocomplete_users
   #user = params[:user]
  #  users = User.where("firstname LIKE ? OR lastname LIKE ?", "%#{params[:user]}%", "%#{params[:user]}%").order(:lastname)
   # render json: users.map { |user| { label: "#{user.first_name} #{user.last_name}", value: user.id } }
#SELECT id, CONCAT(firstname, ' ', lastname) AS fullname FROM helpdesk.users where firstname LIKE '%osales%' OR lastname LIKE '%osales%';
   # render json: @fullnames.map(&:brand_nam)
 # end
end
