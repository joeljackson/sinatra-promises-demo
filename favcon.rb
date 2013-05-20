class Favcon
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.path == '/favicon.ico'
      return [404, {}, []]
    else
      @app.call(env)
    end
  end
end