class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
   
   def locale
    case params[:locale]
    when 'fr'
      I18n.locale = 'fr'
    else
      I18n.locale = 'en'
    end
    
    cookies.permanent[:locale]=I18n.locale    
    redirect_back(fallback_location: root_path)

  end
  
  
end
