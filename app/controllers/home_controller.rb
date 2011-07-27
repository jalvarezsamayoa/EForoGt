class HomeController < ApplicationController
  def index
    @login = Time.now.to_i
    @preguntas = Pregunta.all
    @evento = Evento.last
    @candidatos = Candidato.all(:order => "codigo")
    @promedio = Promedio.last

    @voto = Voto.new(:candidato => 0,
                     :pregunta => 0,
                     :puntaje => nil)
    
  end

  def votar
    params[:voto][:created_at] = Time.now
    params[:voto][:segundo] = Time.now.to_i
    
    @voto = Voto.create(params[:voto])
    
    @promedio = Promedio.last
    @promedio.votar(@voto.puntaje)

    send_to_clients ["promedio", @promedio.valor.to_s ]
    
    render :nothing => true
  end

  private

  def send_to_clients(data)
    Socky.send(data.collect{|d| CGI.escapeHTML(d)}.to_json)
  end

end
