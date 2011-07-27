class RspecModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :name, :type => :string
  
  def generate_spec
    base_directory = "spec/models"
    template "model_spec.rb", "#{base_directory}/#{item}_spec.rb"
  end

  private

  def model
    name
  end
  
  def item
    name.underscore.downcase
  end
  
end
