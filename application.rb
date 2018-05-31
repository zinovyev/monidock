require "erb"

class Application

  def call(env)
    @current_time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @stats = docker_stats
    render :index
  end

  private

  def render(view)
    template = load_view(view)
    erb = ERB.new(template)
    body = erb.result(binding)
    ["200", { "Content-Type" => "text/html" }, [body]]
  end

  def load_view(view)
    @_views ||= {}
    @_views[view.to_sym] ||= begin
      templates = Dir.glob("#{__dir__}/views/#{view}*.erb")
      template_path = File.absolute_path(templates.first)
      File.read(template_path)
    end
  end

  def docker_stats
    io = IO.popen("docker stats --no-stream", "r")
    rows = io.read.split(/\n/).map { |row| row.split(/\s{3,}/) }
    rows.each { |row| row[0], row[1] = row[1], row[0] }
    io.close
    rows
  end
end
