# -*- coding: utf-8 -*-
class Admin::CandidatosController < ApplicationController
  layout 'admin'

  before_filter :authenticate_htaccess

  def index
    @candidatos = Candidato.all(:order => "codigo")

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

        expire_action :controller => "/home", :action => :index
        expire_action :controller => "/home", :action => :estadisticas

        format.html { redirect_to(admin_candidato_path(@candidato)) }
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

        expire_action :controller => "/home", :action => :index
        expire_action :controller => "/home", :action => :estadisticas


        format.html { redirect_to(admin_candidato_path(@candidato)) }
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

    expire_action :controller => "/home", :action => :index
    expire_action :controller => "/home", :action => :estadisticas

    respond_to do |format|
      format.html { redirect_to(admin_candidatos_url) }
      format.xml  { head :ok }
    end
  end

  def reorder
    @candidato = Candidato.find(params[:id])

    codigo =  params[:codigo].to_i

    if codigo > 0
      old_candidato = Candidato.find_by_codigo(codigo)
      old_candidato.codigo = @candidato.codigo
      old_candidato.save

      @candidato.codigo = codigo
      @candidato.save
    end

    expire_action :controller => "/home", :action => :index
    expire_action :controller => "/home", :action => :estadisticas

    redirect_to admin_candidatos_url
  end

end
