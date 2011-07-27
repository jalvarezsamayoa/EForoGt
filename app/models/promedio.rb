class Promedio
  include MongoMapper::Document

  key :votos, Array
  key :n, Integer
  key :valor, Float

  def votar(valor)
    self.votos[0] = self.votos[0] + 1 if valor == 1
    self.votos[1] = self.votos[1] + 1 if valor == 2
    self.votos[2] = self.votos[2] + 1 if valor == 3
    self.votos[3] = self.votos[3] + 1 if valor == 4

    self.n = self.n + 1

    self.valor = ( (self.votos[0] + (2 * self.votos[1]) + (3 * self.votos[2]) + (4 * self.votos[3])).to_f / self.n.to_f )
    
    self.save
  end
  
  def self.reset
    Promedio.delete_all
    Voto.delete_all
    Promedio.create({:n => 0, :valor => 0.0, :votos => [0, 0, 0, 0]})
  end
  
end
