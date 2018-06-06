require "./application"
require "rack-refresher"

use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == ENV.fetch("MONIT_NAME", "monit") &&
    password == ENV.fetch("MONIT_PASSWORD", "secret")
end

use Rack::Refresher do |config|
  config.interval = 300_000
end

use Rack::Refresher do |config|
  config.ajax = true
end

run Application.new
