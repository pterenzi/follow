class LanguagesController < ApplicationController
 
  def change_language
    debugger
    I18n.locale = params[:locale]
    set_locale
    redirect_to :back
  end

end
