require 'google/api_client/client_secrets'
require 'google/apis/oauth2_v2'

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def googleauth
    #session[:googleme] = params[:google][:remember_me]
    auth_uri = user_credentials.authorization_uri.to_s
    redirect_to auth_uri    
  end
  
  def create_google
    if params[:code]
      user_credentials.code = params[:code] 
      user_credentials.fetch_access_token!  
      service = Google::Apis::Oauth2V2::Oauth2Service.new
      
      googleuser = service.get_userinfo_v2(
        :fields  => 'name, email, picture, locale',
        :options => {:authorization => user_credentials})

      log_out if logged_in?
      
      user = User.find_by(email: googleuser.email.downcase)
      if user
        log_in user
        #session[:googleme] == '1' ? remember(user) : forget(user)
        remember(user) 
        #session.delete(:googleme)
        redirect_back_or user
      else
        new_password = SecureRandom.urlsafe_base64
        
        user = User.new(name:  googleuser.name,
                        email: googleuser.email,
                        password: new_password,
                        password_confirmation: new_password,
                        activated: true,
                        activated_at: Time.zone.now,
                        googleaccount: true,
                        googleimage: googleuser.picture)
        
        if user.save
          log_in user
          flash[:success] = I18n.t(:accountactivated)
          redirect_back_or user
        else
          render 'new'
        end
      end
    else
      flash[:danger] =I18n.t(:invalidlogin) # Not quite right!
      redirect_to login_path
      return
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
   private
    def user_credentials  
      @user_credentials ||= (
        client_secrets = Google::APIClient::ClientSecrets.load "client_secret.json"
        auth = client_secrets.to_authorization
        auth.update!(
          :scope => 'https://www.googleapis.com/auth/userinfo.email
                   https://www.googleapis.com/auth/userinfo.profile',
          :redirect_uri => get_uri)
        auth
      )
    end
    
    def get_uri
      @uri ||= (
        if Rails.env.development?
          u = "http://localhost:3000/oauth2callback"
        else
          u = "https://polar-tundra-38481.herokuapp.com/oauth2callback"
        end  
      u
      )
    end
end
