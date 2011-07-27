class Evento
  include MongoMapper::Document

  key :estado, Integer
  key :pregunta, String
  key :candidato, String
  
end
