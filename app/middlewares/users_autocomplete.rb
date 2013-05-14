class UsersAutocomplete
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env["PATH_INFO"] == "/profiles/autocomplete"
      request = Rack::Request.new(env)
      terms = UserProfile.autocomplete(request.params["term"] || "")
      [200, {"Content-type" => "application/json"}, [terms.to_json]]
    else
      @app.call(env)
    end 
  end
end
