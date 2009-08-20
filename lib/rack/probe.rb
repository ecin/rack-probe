class Symbol
  unless instance_methods.include? :to_proc
    def to_proc
      Proc.new { |obj, *args| obj.send(self, *args) }
    end
  end
end

module Rack
  class Probe
    
    gem 'ruby-dtrace', '>= 0.2.7'
    require 'dtrace/provider'
        
    def initialize( app, opts = {} )
      # Unless our probes are already defined...
      unless Dtrace::Probe::Rack.instance_of? Dtrace::Provider::Klass
        Dtrace::Provider.create :rack do |p|
          p.probe :get                # GET request
          p.probe :post               # POST request
          p.probe :put                # PUT request
          p.probe :delete             # DELETE request
          p.probe :ip,  :string       # IP of the requester
          p.probe :path,  :string     # Path visited 
          p.probe :referer, :string   # Referer
          p.probe :xhr                # AJAX request
          
          p.probe :request_start      # Start of a request
          p.probe :request_finish     # End of a request
        end
      end
    
      # Provider shortcut
      @R = Dtrace::Probe::Rack
      @app = app
    end

    def call( env )
      @R.request_start(&:fire)
      request = Rack::Request.new env
      @R.get(&:fire) if request.get?
      @R.post(&:fire) if request.post?
      @R.put(&:fire)  if request.put?
      @R.delete(&:fire) if request.delete?
      @R.xhr(&:fire) if request.xhr?
      @R.path    { |p| p.fire(request.path) }
      @R.ip      { |p| p.fire(request.ip) }
      @R.referer { |p| p.fire(request.referer) }
      response = @app.call(env)
      @R.request_finish(&:fire)
      response
    end

  end
end