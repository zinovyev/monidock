class DockerContainer
  ATTRIBUTES = %i[name id cpu_percent mem_usage_limit
                  mem_percent net_io block_io pids].freeze

  attr_accessor(*ATTRIBUTES, :docker)

  def initialize(stats, docker = nil)
    if stats.is_a?(Array)
      stats.each_with_index do |stats_value, stats_index|
        attr_name = ATTRIBUTES[stats_index]
        public_send("#{attr_name}=", stats_value)
      end
    else
      stats.each do |attr_name, stats_value|
        public_send("#{attr_name}=", stats_value)
      end
    end
    @docker = docker
  end

  def top
    @docker.top(id)
  end
end
