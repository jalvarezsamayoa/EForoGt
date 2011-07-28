class HomeController < ApplicationController
  def index
    @login = Time.now.to_i
    
    @preguntas = Pregunta.all
    @candidatos = Candidato.all(:order => "codigo")
  
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
    
    render :nothing => true
  end

  def estado
    evento = Evento.last
    promedio = Promedio.last

    json_response = {:estado => evento.estado,
      :pregunta => evento.pregunta,
      :candidato => evento.candidato,
      :promedio => promedio.valor,
      :usuario => Time.now.to_i}

    respond_to do |wants|
      wants.json {  render :json => json_response.to_json }
    end
  end
  

end
