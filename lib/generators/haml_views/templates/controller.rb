# -*- coding: utf-8 -*-
class <%= controller_name %> < ApplicationController

  access_control do
    allow :administrador
  end

  def index
 
    q = params[:search].nil? ? '' : '%'+params[:search][0]+'%'
    @<%= items %> = <%= model %>.where("<%= attribute_name %> like ?",q).paginate(:page => params[:page])    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= items %> }
    end
  end
  
  def show
    @<%= item %> = <%= model %>.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= item %> }
    end
  end
  
  def new
    @<%= item %> = <%= model %>.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= item %> }
    end
  end
  
  def edit
    @<%= item %> = <%= model %>.find(params[:id])
  end
  
  def create
    @<%= item %> = <%= model %>.new(params[:<%= item %>])
    
    respond_to do |format|
      if @<%= item %>.save
        flash[:notice] = 'Registro creado con éxito.'
        format.html { redirect_to(<%= admin_redirect_url %>) }
        format.xml  { render :xml => @<%= item %>, :status => :created, :location => @<%= item %> }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= item %>.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @<%= item %> = <%= model %>.find(params[:id])
    
    respond_to do |format|
      if @<%= item %>.update_attributes(params[:<%= item %>])
        flash[:notice] = 'Registro actualizado con éxito.'
        format.html { redirect_to(<%= admin_redirect_url %>) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= item %>.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @<%= item %> = <%= model %>.find(params[:id])
    @<%= item %>.destroy

    respond_to do |format|
      if @<%= item %>.destroy
        format.html { redirect_to(<%= admin_path %><%= items %>_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show"}
      end
    end    
  end

end
