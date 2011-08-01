class PromedioCandidato
  include MongoMapper::Document

#  key :candidato, String
#  key :pregunta, String
  key :votos, Array
  key :n, Integer
  key :valor, Float

  belongs_to :candidato
  belongs_to :pregunta


  def self.guardar_estado_actual
    e = Evento.last
    p = Promedio.last

    PromedioCandidato.create(:candidato => Candidato.find(e.candidato),
                             :pregunta => Pregunta.find(e.pregunta),
                             :votos => p.votos,
                             :n => p.n,
                             :valor => p.valor )
  end

  def self.reset
    PromedioCandidato.delete_all
    PromedioCandidato.create({:candidato => Candidato.first, :pregunta => Pregunta.first, :n => 0, :valor => 0.00, :votos => [0,0,0,0,0] })
  end
  
  
end
