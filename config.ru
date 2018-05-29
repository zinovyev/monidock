require "./application"
require "./rack/page_reloader"

use Rack::PageReloader do |config|
  config.interval = 30000
end

use Rack::PageReloader do |config|
  config.interval = 1000
  config.ajax     = true
end

run Application.new
