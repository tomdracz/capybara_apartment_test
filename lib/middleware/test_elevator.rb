class TestElevator < Apartment::Elevators::Generic
  # @return {String} - The tenant to switch to
  def parse_tenant_name(request)
    # request is an instance of Rack::Request

    domain = request.host
    tenant_name = Site.find_by(domain: domain)&.parameterized_name

    tenant_name
  end
end
