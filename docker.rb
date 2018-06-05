require "./docker_container"

class Docker
  def initialize
    @_io_cache = {}
  end

  def stats(reload = true)
    io_table("docker stats --no-stream", "r", reload: reload) do |row|
      row[0], row[1] = row[1], row[0]
      row
    end
  end

  def containers
    containers = stats.dup
    containers.shift
    containers.map { |stats| DockerContainer.new(stats, self) }
  end

  def ls_networks(reload = true)
    io_table("docker network ls", "r", reload: reload)
  end

  def top(container_id, reload = true)
    io_table("docker top #{container_id}", "r", reload: reload)
  end

  private

  def io_table(*args, **options)
    local_cache(args, options) do
      io = IO.popen(*args)
      rows = io.read.split(/\n/).map do |row|
        columns = row.split(/\s{3,}/)
        block_given? ? yield(columns) : columns
      end
      io.close
      rows
    end
  end

  def local_cache(args, options)
    cached = @_io_cache[args]
    return cached if cached && !options[:reload]
    @_io_cache[args] = yield
  end
end
