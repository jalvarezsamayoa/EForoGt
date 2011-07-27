class Pregunta
  include MongoMapper::Document

  key :orden, Integer
  key :texto, String

  validates_presence_of :orden, :texto

  def to_label
    orden.to_s + '. ' + texto
  end
end
