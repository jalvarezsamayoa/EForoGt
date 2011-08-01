# -*- coding: utf-8 -*-
class Admin::EventosController < ApplicationController
  layout 'admin'
  before_filter :authenticate_htaccess
  
  # access_control do
  #   allow :administrador
  # end

  def index
 
    q = params[:search].nil? ? '' : '%'+params[:search][0]+'%'
    # @eventos = Evento.where("nombre like ?",q).paginate(:page => params[:page])
    @eventos = Evento.all.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @eventos }
    end
  end
  
  def show
    @evento = Evento.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evento }
    end
  end
  
  def new
    @evento = Evento.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evento }
    end
  end
  
  def edit
    @evento = Evento.find(params[:id])
  end
  
  def create
    @evento = Evento.new(params[:evento])
    
    respond_to do |format|
      if @evento.save
        flash[:notice] = 'Registro creado con éxito.'
        format.html { redirect_to(admin_evento_path(@evento)) }
        format.xml  { render :xml => @evento, :status => :created, :location => @evento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evento.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @evento = Evento.find(params[:id])
    
    respond_to do |format|

      if params[:evento][:estado]

        params[:evento][:pregunta] = Pregunta.first(:order => "orden").id.to_s
        params[:evento][:candidato] = Candidato.first(:order => "codigo").id.to_s

      else        
        params[:evento][:candidato] = Candidato.first(:order => "codigo").id.to_s if params[:evento][:pregunta]

         PromedioCandidato.guardar_estado_actual
      end
      
      if @evento.update_attributes(params[:evento])

        Promedio.reset(false)

        expire_page :controller => "/home", :action => :estadisticas
        
        format.html { redirect_to(admin_dashboard_path) }
      
      else
        format.html { render :action => "edit" }      
      end
    end
  end
  
  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy

    respond_to do |format|
      if @evento.destroy
        format.html { redirect_to(admin_eventos_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show"}
      end
    end    
  end


  def reset
    Evento.delete_all
    PromedioCandidato.reset
    Promedio.reset
    Evento.create(:estado => 0, :pregunta => Pregunta.first(:order => "codigo").id, :candidato => Candidato.first.id)
     
    expire_page :controller => "/home", :action => :index
    expire_page :controller => "/home", :action => :estadisticas
    
    flash[:notice] = "Votos reiniciados con exito."
    
    redirect_to admin_dashboard_url
  end
 
end
