# -*- coding: utf-8 -*-
class CandidatosController < ApplicationController

  access_control do
    allow :administrador
  end

  def index
 
    q = params[:search].nil? ? '' : '%'+params[:search][0]+'%'
    @candidatos = Candidato.where("nombre like ?",q).paginate(:page => params[:page])    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @candidatos }
    end
  end
  
  def show
    @candidato = Candidato.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @candidato }
    end
  end
  
  def new
    @candidato = Candidato.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @candidato }
    end
  end
  
  def edit
    @candidato = Candidato.find(params[:id])
  end
  
  def create
    @candidato = Candidato.new(params[:candidato])
    
    respond_to do |format|
      if @candidato.save
        flash[:notice] = 'Registro creado con éxito.'
        format.html { redirect_to(@candidato) }
        format.xml  { render :xml => @candidato, :status => :created, :location => @candidato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @candidato.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @candidato = Candidato.find(params[:id])
    
    respond_to do |format|
      if @candidato.update_attributes(params[:candidato])
        flash[:notice] = 'Registro actualizado con éxito.'
        format.html { redirect_to(@candidato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @candidato.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @candidato = Candidato.find(params[:id])
    @candidato.destroy

    respond_to do |format|
      if @candidato.destroy
        format.html { redirect_to(candidatos_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show"}
      end
    end    
  end

end
