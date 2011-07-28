class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_filter :authenticate_htaccess
  
  def show
    @evento = Evento.last
    @preguntas = Pregunta.all(:order => "orden")
    @candidatos = Candidato.all(:order => "codigo")
  end

  def siguiente_pregunta
    Evento.siguiente_pregunta
    redirect_to(admin_dashboard_path)
  end

  def siguiente_candidato
    unless Evento.siguiente_candidato
      Evento.siguiente_pregunta
    end
    redirect_to(admin_dashboard_path)
  end
  
end
