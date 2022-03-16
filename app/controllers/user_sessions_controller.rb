require 'net-ldap'
class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end
  
  #  Uncomment to use system without LDAP authentication
  #  def create
  #    @user_session = UserSession.new(params[:user_session])
  #    if @user_session.save
  #      flash[:notice] = "Login successful!"
  #      redirect_back_or_default home_url
  #    else
  #      render :action => :new
  #    end
  #  end

  def create
    if authenticate_ldap?(params[:user_session][:login], params[:user_session][:password]) and !User.find_by_login(params[:user_session][:login]).nil?
     puts 'ldap bien'
      @session = UserSession.new(params[:user_session].merge(:password=>'qw12..'))
      puts @sesion
      puts @session.login.to_s
      @session.save
      #redirect_to home_url
      redirect_back_or_default home_url
    else
     puts 'ldap mal'
      @user_session = UserSession.new
      render 'new'
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
  
  def dn(login)
    ldap.search(:base => ldap_config['base'], :filter => Net::LDAP::Filter.eq("uid", login), :return_result => true ).first.dn
  end
  
  def authenticate_ldap?(login, password)
    @ldap = ldap
    @ldap.auth(dn(login), password)
    @ldap.bind
  end     

  def send_students_message 
  end

end
