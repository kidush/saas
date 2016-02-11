class SessionsController < Devise::SessionsController

  def new
    if request.subdomain.present? || request.subdomain == 'www'
      flash[:notice] = "Accesso negato"
      redirect_to :root
    else
      super
    end
  end

end