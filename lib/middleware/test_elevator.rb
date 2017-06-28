class TestElevator < Apartment::Elevators::Generic
  # @return {String} - The tenant to switch to

  def call(env)
    if Rails.env == "test" && env["HTTP_USER_AGENT"]&.match?("PhantomJS")
      request = Rack::Request.new(env)
      database = @processor.call(request)
      Apartment::Tenant.switch! database if database
      @app.call(env)
    else
      super
    end
  end

  def parse_tenant_name(request)
    # request is an instance of Rack::Request

    domain = request.host
    tenant_name = Site.find_by(domain: domain)&.parameterized_name

    tenant_name
  end
end
