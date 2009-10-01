class LanguagesController < ApplicationController
 #TODO estudar como funciona o default_url_option em application_controller
  def change_language
    debugger
    I18n.locale = params[:locale]
    puts "Locale trocado " + I18n.locale
  #  set_locale
    redirect_to :back
  end

end
