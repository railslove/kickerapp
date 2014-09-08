class Vwo <  Rack::Tracker::Handler
  def render
    Tilt.new( File.join( File.dirname(__FILE__), 'vwo/template', 'vwo.erb') ).render(self)
  end
end
