class HamlViewsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, :type => :string
  argument :type, :type => :string, :default => "", :description => "vistas son de admin"
  argument :item_name, :type => :string, :default => "", :description => "nombre en singular de modelo"
  argument :items_name, :type => :string, :default => "", :description => "nombre en plural de modelo"
  argument :attribute_name, :type => :string, :default => "nombre", :description => "nombre de atributo a desplegar"

  def generate_views

    if admin_view?
      base_directory_views = "app/views/admin/#{items}"
      base_directory_controller = "app/controllers/admin"
    else
      base_directory_views = "app/views/#{items}"
      base_directory_controller = "app/controllers"
    end
    
    empty_directory(base_directory_views)
    template "index.html.haml", "#{base_directory_views}/index.html.haml"
    template "_breadcrumbs.html.haml", "#{base_directory_views}/_breadcrumbs.html.haml"
    template "show.html.haml", "#{base_directory_views}/show.html.haml"
    template "new.html.haml", "#{base_directory_views}/new.html.haml"
    template "edit.html.haml", "#{base_directory_views}/edit.html.haml"
    template "_form.html.haml", "#{base_directory_views}/_form.html.haml"
    template "controller.rb", "#{base_directory_controller}/#{items}_controller.rb"
  end

  private

  def admin_path(middle = false)
    return '' unless admin_view?
    return 'admin_' if middle
    return 'admin_'
  end

  def admin_url(update = false)
    return '' unless admin_view?
    return ", :url => admin_#{item}_path(@#{item})" if update
    return ", :url => admin_#{items}_path"
  end

  def admin_redirect_url
    return "@#{item}" unless admin_view?
    return "admin_#{item}_path(@#{item})"
  end
  
  def admin_view?
    return true if type == 'admin'
    false
  end

  def model
    model_name.constantize
  end
  
  def item
    return item_name unless item_name.empty?
    model_name.underscore.downcase
  end

  def items
    return items_name unless items_name.empty?
    item.pluralize
  end

  def controller_name
    name = model_name.pluralize.capitalize + "Controller"
    if admin_view?
      name = 'Admin::' + name
    end
    return name
  end

  def attributes
    model.new.attributes
  end

  
end
