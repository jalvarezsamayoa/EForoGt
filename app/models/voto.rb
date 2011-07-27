class Voto
  include MongoMapper::Document

  key :candidato, String
  key :pregunta, String
  key :puntaje, Integer
  key :created_at, Time
  key :segundo, Integer

  
end

