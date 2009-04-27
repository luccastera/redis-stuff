namespace :redis do

  desc "Install redis"
  task :install do
    ["cd src",
     "git clone git://github.com/antirez/redis.git /tmp/redis",
     "cd /tmp/redis && git pull",
     "cd /tmp/redis && make clean",
     "cd /tmp/redis && make",
     "sudo cp /tmp/redis/redis-benchmark /usr/bin/",
     "sudo cp /tmp/redis/redis-cli /usr/bin/",
     "sudo cp /tmp/redis/redis-server /usr/bin/",
     "sudo cp /tmp/redis/redis.conf /etc/",
     "sudo sed -i 's/daemonize no/daemonize yes/' /etc/redis.conf",
     "sudo sed -i 's/^pidfile \/var\/run\/redis.pid/pidfile \/tmp\/redis.pid/' /etc/redis.conf"].each {|cmd| run cmd}     
  end
  
  desc "Install redis-rb gem"
  task :install_rubygem do
    # the gem currently needs to have rspec installed to make it work so that's why I install rspec here
    sudo "gem install rspec --no-ri --no-rdoc"
    ["cd src && git clone git://github.com/ezmobius/redis-rb.git",
     "cd ~/src/redis-rb && sudo rake install"].each {|cmd| run cmd}
  end  
  
  desc "Start the Redis server"
  task :start do
    run "redis-server /etc/redis.conf"
  end
  
  desc "Stop the Redis server"
  task :stop do
    run 'echo "SHUTDOWN" | nc localhost 6379'
  end

end
