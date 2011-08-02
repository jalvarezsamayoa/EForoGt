class EventoSweeper < ActionController::Caching::Sweeper
  observe Evento # This sweeper is going to keep an eye on the Evento model

  # If our sweeper detects that a Evento was created call this
  def after_create(evento)
    expire_cache_for(evento)
  end

  # If our sweeper detects that a Evento was updated call this
  def after_update(evento)
    expire_cache_for(evento)
  end

  # If our sweeper detects that a Evento was deleted call this
  def after_destroy(evento)
    expire_cache_for(evento)
  end

  private
  def expire_cache_for(evento)
    # Expire the index page now that we added a new evento
    expire_action(:controller => 'home', :action => 'index')
    expire_action(:controller => 'home', :action => 'estadisticas')
   end
end
