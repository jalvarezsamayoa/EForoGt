class PromedioCandidato
  include MongoMapper::Document

  key :candidato, String
  key :pregunta, String
  key :votos, Array
  key :n, Integer
  key :valor, Float

  def self.guardar_estado_actual
    e = Evento.last
    p = Promedio.last

    PromedioCandidato.create(:candidato => e.candidato,
                             :pregunta => e.pregunta,
                             :votos => p.votos,
                             :n => p.n,
                             :valor => p.valor )
  end

  def self.reset
    PromedioCandidato.delete_all
  end
  
  
end
