module RescueApartmentMiddleware

  def call(*args)
    begin
      super
    rescue Apartment::TenantNotFound
      return [404, {'content-type' => 'text/html'}, ["#{File.read(Rails.root.to_s + '/public/404.html')}"] ]
    end
  end

end