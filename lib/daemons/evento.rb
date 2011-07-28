# -*- coding: utf-8 -*-
require File.expand_path('../../../config/environment',  __FILE__)

def iniciar_data
  Evento.delete_all
  Candidato.delete_all
  Pregunta.delete_all
  Promedio.reset(true)

  (1..20).each do |i|
    Pregunta.create(:orden => i,
                    :texto => "¿Este es el largo texto de la pregunta numero #{i} del foro virtual guatemala 2011?")
  end

  (1..10).each do |i|
    Candidato.create(:codigo => i,
                     :nombre => "Candidato #{i}",
                     :partido => "Partido Politico #{i}",
                     :url => "http://partidopolitico_#{i}.org.gt",
                     :slug => "partido#{i}",
                     :imagen => 'http://cdn.pimpmyspace.org/media/pms/c/q2/26/6s/peace_sign.png')
  end

  Evento.create(:estado => 0, :pregunta => Pregunta.first.id, :candidato => Candidato.first.id)

end


#File.open(File.dirname(__FILE__)+'/evento.log','w') do |log|
  puts "Cargando data.."
  iniciar_data()
  puts "ok.. esperando"

  numero_preguntas = Pregunta.count
  numero_candidatos = Candidato.count

  sleep(20)
  
  puts "Iniciando evento #{Time.now}"
  Evento.start



  (2..numero_preguntas).each do |i|
    (2..numero_candidatos).each do |j|
      
      sleep(10)
      
      puts "Actualizando candidato #{j}"
      unless Evento.siguiente_candidato()
        puts "Actualizando pregunta #{i}"
        Evento.siguiente_pregunta()
      end
    end
  end
  
  puts "Terminando evento #{Time.now}"
  Evento.stop
#end
