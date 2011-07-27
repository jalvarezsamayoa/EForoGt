# -*- coding: utf-8 -*-
class Admin::PreguntasController < ApplicationController

  layout 'admin'
  
  # access_control do
  #   allow :administrador
  # end

  def index
 
    q = params[:search].nil? ? '' : '%'+params[:search][0]+'%'
    #    @preguntas = Pregunta.where("texto like ?",q).paginate(:page
    #    => params[:page])    
    @preguntas = Pregunta.all.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntas }
    end
  end
  
  def show
    @pregunta = Pregunta.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end
  
  def new
    @pregunta = Pregunta.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end
  
  def edit
    @pregunta = Pregunta.find(params[:id])
  end
  
  def create
    @pregunta = Pregunta.new(params[:pregunta])
    
    respond_to do |format|
      if @pregunta.save
        flash[:notice] = 'Registro creado con éxito.'
        format.html { redirect_to(admin_pregunta_path(@pregunta)) }
        format.xml  { render :xml => @pregunta, :status => :created, :location => @pregunta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pregunta.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @pregunta = Pregunta.find(params[:id])
    
    respond_to do |format|
      if @pregunta.update_attributes(params[:pregunta])
        flash[:notice] = 'Registro actualizado con éxito.'
        format.html { redirect_to(admin_pregunta_path(@pregunta)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pregunta.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @pregunta = Pregunta.find(params[:id])
    @pregunta.destroy

    respond_to do |format|
      if @pregunta.destroy
        format.html { redirect_to(admin_preguntas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show"}
      end
    end    
  end

end
