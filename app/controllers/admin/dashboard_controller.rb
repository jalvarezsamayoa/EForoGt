class Admin::DashboardController < ApplicationController
  layout 'admin'
  
  def show
    @evento = Evento.last
    @preguntas = Pregunta.all(:order => "orden")
    @candidatos = Candidato.all(:order => "codigo")
  end

  

  
  private

  def send_to_clients(data)
    Socky.send(data.collect{|d| CGI.escapeHTML(d)}.to_json)
  end
  
end
