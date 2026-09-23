require 'net-ldap'
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end
  
  def create
    login = params[:user_session] ? params[:user_session][:login] : nil
    password = params[:user_session] ? params[:user_session][:password] : nil

    # Se verifica que ambos campos estén presentes antes de consultar LDAP
    if login.present? && password.present? && authenticate_ldap?(login, password) && User.find_by_login(login)
      puts 'ldap bien'
      @session = UserSession.new(params[:user_session].merge(:password => 'qw12..'))
      if @session.save
        flash[:notice] = "¡Inicio de sesión exitoso!"
        redirect_back_or_default home_url
      else
        flash.now[:alert] = "Error al iniciar sesión."
        @user_session = @session
        render :action => :new
      end
    else
      puts 'ldap mal o campos vacíos'
      @user_session = UserSession.new(params[:user_session])
      @user_session.errors.add(:base, "Usuario o contraseña no válidos.")
      flash.now[:alert] = "Por favor ingresa un usuario y contraseña válidos."
      render :action => :new
    end
  end
  #def create
  #  if authenticate_ldap?(params[:user_session][:login], params[:user_session][:password]) and !User.find_by_login(params[:user_session][:login]).nil?
  #   puts 'ldap bien'
  #    @session = UserSession.new(params[:user_session].merge(:password=>'qw12..'))
  #    puts @sesion
  #    puts @session.login.to_s
  #    @session.save
      #redirect_to home_url
  #    redirect_back_or_default home_url
  #  else
  #   puts 'ldap mal'
  #    @user_session = UserSession.new
  #    render 'new'
  #  end
  #end

  def create
    login = params[:user_session][:login]
    password = params[:user_session][:password]

    if authenticate_ldap?(login, password) && !User.find_by_login(login).nil?
      puts 'ldap bien'
      @session = UserSession.new(params[:user_session].merge(:password => 'qw12..'))
      if @session.save
        flash[:notice] = "¡Inicio de sesión exitoso!"
        redirect_back_or_default home_url
      else
        flash.now[:alert] = "Error al iniciar sesión."
        @user_session = @session
        render :action => :new
      end
    else
      puts 'ldap mal'
      @user_session = UserSession.new(params[:user_session])
      # Agrega el mensaje de error al modelo para que lo lea _error_messages.html.erb
      @user_session.errors.add(:base, "Usuario o contraseña no válidos.")
      flash.now[:alert] = "Usuario o contraseña no válidos."
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_back_or_default new_user_session_url
  end
  
  def ldap_config
    YAML.load(ERB.new(File.read("/home/daniel/workspace/SuperHELPDESK/config/ldap.yml")).result)['production']
  end
  
  def ldap
    Net::LDAP.new(:host => ldap_config['host'], :port => ldap_config['port'], :encryption => (ldap_config['ssl'] ? :simple_tls : nil),
                  :auth => { :method => :simple, :username => ldap_config['admin_user'], :password => ldap_config['admin_password'] })
  end
  
  #def dn(login)
  #  ldap.search(:base => ldap_config['base'], :filter => Net::LDAP::Filter.eq("uid", login), :return_result => true ).first.dn
  #end
  def dn(login)
    return nil if login.blank?

    result = ldap.search(:base => ldap_config['base'], :filter => Net::LDAP::Filter.eq("uid", login), :return_result => true)
    # Retorna el DN solo si encontró un registro en LDAP[cite: 3]
    result && result.first ? result.first.dn : nil
  end
  
  #def authenticate_ldap?(login, password)
  #  @ldap = ldap
  #  @ldap.auth(dn(login), password)
  #  @ldap.bind
  #end     
  def authenticate_ldap?(login, password)
    return false if login.blank? || password.blank?

    user_dn = dn(login)
    return false if user_dn.nil?

    @ldap = ldap
    @ldap.auth(user_dn, password)
    @ldap.bind
  rescue StandardError => e
    Rails.logger.error("Error en autenticación LDAP: #{e.message}")
    false
  end

  def send_students_message 
  end

end
