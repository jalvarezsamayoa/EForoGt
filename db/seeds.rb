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

Evento.create(:estado => 0, :pregunta => nil, :candidato => nil)

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

Promedio.reset
