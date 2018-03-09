class StaticPagesController < ApplicationController

  before_action :set_breadcrumb

  def home
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def help
    add_breadcrumb I18n.t(:help), :help_path
  end

  def about
    add_breadcrumb I18n.t(:about), :about_path
  end

  def contact
    add_breadcrumb I18n.t(:contact), :contact_path
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

  private
    def set_breadcrumb
      add_breadcrumb I18n.t(:home), :root_path
    end

end
