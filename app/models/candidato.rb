class Candidato
  include MongoMapper::Document

  key :codigo, Integer
  key :nombre, String
  key :partido, String
  key :url, String
  key :slug, String
  key :imagen, String

  validates_presence_of :codigo, :nombre, :partido, :url, :imagen


  def to_label
    codigo.to_s + '. ' + nombre
  end
end
