# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Evento.delete_all
Candidato.delete_all
Pregunta.delete_all



(1..54).each do |i|
  Pregunta.create(:orden => i,
                  :texto => "¿Este es el largo texto de la pregunta numero #{i} del foro virtual guatemala 2011?")
end


Candidato.create(:codigo => 1,
                 :nombre => "Otto Pérez Molina",
                 :partido => "Partido Patriota",
                 :url => "http://www.partidopatriota.com/",
                 :slug => "patriota",
                 :imagen => 'http://eleccionesguatemala.org/wp-content/uploads/2011/04/otto-perez-molina.jpg')

Candidato.create(:codigo => 2,
                 :nombre => "Dr. Eduardo Suger",
                 :partido => "Compromiso Renovacion y Cambio",
                 :url => "http://creo.org.gt/",
                 :slug => "creo",
                 :imagen => 'http://lamp02.entravision.com/Media/images/El-academico-Eduardo-Suger-es-proclamado-candidato-a-la-Presidencia-de-Guatemala.jpg')

Candidato.create(:codigo => 3,
                 :nombre => "Dr. Manuel Baldizón",
                 :partido => "Partido Líder",
                 :url => "http://www.metropolitanalider.com/",
                 :slug => "lider",
                 :imagen => 'http://www.elperiodico.com.gt/templates/image_jotac.php?NrArticle=103817&NrImage=1&w=270')

Candidato.create(:codigo => 4,
                 :nombre => "Dr. Harold Caballeros",
                 :partido => "Visión con Valores",
                 :url => "http://www.visionconvalores.com/",
                 :slug => "viva",
                 :imagen => 'http://agn.gob.gt/agn/images/fotos/2011/julio/0707-11/harold-caballeros-candidato-presidencia.jpg')


PromedioCandidato.create({:candidato => '', :pregunta => '', :n => 0, :valor => 0.00, :votos => [0,0,0,0] })

Promedio.reset
PromedioCandidato.reset


Evento.create(:estado => 0, :pregunta => Pregunta.first.id, :candidato => Candidato.first.id)
