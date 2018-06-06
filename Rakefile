task default: %w[start]

task :start do
  system "bundle exec rackup -P tmp/server.pid -D -p 19295"
end

task :stop do
  system "kill `cat tmp/server.pid`"
end

task :status do
  pid_file = "tmp/server.pid"
  pid = IO.readlines(pid_file)[0] if File.exist?(pid_file)
  result = if pid
             popen = IO.popen("kill -0 #{pid} 2>/dev/null ; echo $?", "r")
             popen.readlines[0].strip
  end
  if result
    puts "Alive #{pid}"
  else
    puts "Stopped"
  end
end
