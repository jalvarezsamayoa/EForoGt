# -*- coding: utf-8 -*-
module ApplicationHelper
    def button(text = 'Grabar', icon = 'accept16.png')
    c_return = '<button type="submit" class="button">'
    c_return += image_tag(icon) + text
    c_return += '</button>'
    raw(c_return)
  end

  def button_create(text = 'Grabar Nuevo')
    return button(text)
  end

  def button_update(text = 'Grabar Cambios')
    return button(text)
  end

  def button_link(url = "#", text = 'Click Me', title = 'Click me', icon = 'accept16.png', positive = true, delete = false  )
    c_icon = image_tag(icon)
    c_id = text.empty? ? nil : text.downcase.gsub(' ','-')

    unless delete
      if positive == true
        c_return = link_to c_icon  + text, url, :class => 'button positive', :id => c_id, :title => title
      else
        c_return = link_to c_icon  + text, url, :class => 'button negative', :id => c_id, :title => title
      end
    else

      c_return = link_to c_icon  + text, url, :class => 'button negative', :id => c_id, :title => title, :method => :delete, :confirm => '¿Está seguro de eliminar el registro?'
    end

    return raw(c_return)
  end

  def button_new(url = "#", text = 'Nuevo', title = 'Crea nuevo registro')
    return button_link(url, text, title, 'add16.png')
  end

  def button_edit(url = "#", text = 'Editar')
    return button_link(url, text, "Editar información.", 'edit16.png')
  end

  def button_delete(url = "#", text = 'Eliminar', title = 'Eliminar el registro.')
    return button_link(url, text, title, 'delete16.png', false, true)
  end

  def button_cancel(url = "#", text = 'Cancelar')
    return button_link(url, text, "Cancelar operación.", 'undo16.png', false)
  end


  def button_print(url = "#", text = 'Imprimir', title = 'Imprime Documento')
    c_return = link_to image_tag('printer16.png') + text, url, :class => 'button positive', :title => title, :popup => true
    return raw(c_return)
  end

  def button_export(url = "#", text = 'Exportar')
    c_return = link_to image_tag('down16.png') + text, url, :class => 'button positive', :title => "Exporta Documento a Plantilla.", :popup => true
    return raw(c_return)
  end


  def buttons_create(url = "#")
    return button_create + button_cancel(url)
  end

  def buttons_update(url = "#")
    return button_update + button_cancel(url)
  end

  def si_no(valor)
    valor ? 'Si' : 'No'
  end

  #//////////////////////////////////////////////////////
  # helpers para agregar hijos a forma
  #//////////////////////////////////////////////////////

  def remove_child_link(name, f)
    link_to(name, "javascript:void(0)", :class => "remove_child button negative", :id => 'destroy_'+f.object.id.to_s ) + f.hidden_field(:_destroy)
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child button positive", :"data-association" => association)
  end

  def new_child_fields_template(form_builder, association, options = {})
    logger.debug { "-----------------------------------------" }
    logger.debug { "form_builder: #{form_builder}" }

    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end
end
