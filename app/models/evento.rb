class Evento
  include MongoMapper::Document

  NOINICIADO = 0
  INICIAR = 1
  TERMINAR = 2


  key :estado, Integer
  key :pregunta, String
  key :candidato, String

  def self.start
    e =  Evento.last
    e.estado = INICIAR
    e.save
  end

  def self.stop
    e =  Evento.last
    e.estado = TERMINAR
    e.save
  end

  def self.siguiente_pregunta(guardar_estado = true)
    PromedioCandidato.guardar_estado_actual if guardar_estado

    e =  Evento.last

    n =  Pregunta.count
    pregunta_actual = Pregunta.find(e.pregunta)

    n1 = pregunta_actual.orden + 1

    siguiente_pregunta = Pregunta.first(:orden => n1)

    if siguiente_pregunta.nil?
      return false
    else
      Promedio.reset(false)

      e.pregunta = siguiente_pregunta.id.to_s
      e.candidato = Candidato.first(:order => "codigo").id.to_s
      e.save
    end
  end

  def self.siguiente_candidato
    PromedioCandidato.guardar_estado_actual

    e =  Evento.last
    n = Candidato.count
    candidato_actual = Candidato.find(e.candidato)
    c1 = candidato_actual.codigo + 1
    siguiente_candidato = Candidato.first(:codigo => c1)

    if siguiente_candidato.nil?
      return false
    else

      Promedio.reset(false)

      e.candidato = siguiente_candidato.id.to_s
      e.save
    end
  end

  def self.set_pregunta(pregunta_id)
    PromedioCandidato.guardar_estado_actual

    e =  Evento.last
    Promedio.reset(false)
    
    e.pregunta = pregunta_id
    e.candidato = Candidato.first(:order => "codigo").id.to_s
    e.save

  end



end
