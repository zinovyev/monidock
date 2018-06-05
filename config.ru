require "./application"
require "rack-refresher"

use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == "monit" && password == "Aifee7ae"
end

use Rack::Refresher do |config|
  config.interval = 30000
end

use Rack::Refresher do |config|
  config.ajax     = true
end

run Application.new
