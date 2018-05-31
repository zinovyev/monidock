require "./application"
require "rack-refresher"

use Rack::Refresher do |config|
  config.interval = 30000
end

use Rack::Refresher do |config|
  config.ajax     = true
end

run Application.new
