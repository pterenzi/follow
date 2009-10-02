class LanguagesController < ApplicationController
 #TODO estudar como funciona o default_url_option em application_controller
  def change_language
    I18n.locale = params[:locale]
    puts "Locale trocado " + I18n.locale
    redirect_to tasks_path # TODO permitir voltar para a action anterior
  end

end
