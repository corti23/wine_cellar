class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :set_locale
 
  private
   
  def set_locale
    #I18n.locale = extract_locale || I18n.default_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = cookies[:locale] || extract_locale_from_accept_language_header unless Rails.env.test?
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
   
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
    
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
#  def default_url_options
#  { locale: I18n.locale }
#  end

end
