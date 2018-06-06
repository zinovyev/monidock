require "erb"
require "./docker"
require "./helper"

class Application
  include Helper

  def call(_env)
    current_time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    render :index, locals: {
      containers: docker.containers,
      current_time: current_time,
      networks: docker.ls_networks
    }
  end

  private

  def render(view, options)
    template = load_view(view)
    erb = ERB.new(template)
    binding = get_binding
    bind_locals(binding, options[:locals])
    body = erb.result(binding)
    ["200", { "Content-Type" => "text/html" }, [body]]
  end

  def bind_locals(binding, locals)
    locals.each { |var, val| binding.local_variable_set(var, val) }
  end

  def load_view(view)
    @_views ||= {}
    @_views[view.to_sym] ||= begin
      templates = Dir.glob("#{__dir__}/views/#{view}*.erb")
      template_path = File.absolute_path(templates.first)
      File.read(template_path)
    end
  end

  def get_binding
    binding
  end

  def docker
    @_docker ||= Docker.new
  end
end
