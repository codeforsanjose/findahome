require 'net/telnet'
require 'socksify'
require 'mechanize'

original_ip = Mechanize.new.get("http://bot.whatismyipaddress.com").content
puts "original IP is : #{original_ip}"

# socksify will forward traffic to Tor so you dont need to set a proxy for Mechanize from there
TCPSocket::socks_server = "127.0.0.1"
TCPSocket::socks_port = "50001"
tor_port = 9050

2.times do
  #Switch IP
  localhost = Net::Telnet::new("Host" => "localhost", "Port" => "#{tor_port}", "Timeout" => 10, "Prompt" => /250 OK\n/)
  localhost.cmd('AUTHENTICATE "foobar"') { |c| print c; throw "Cannot authenticate to Tor" if c != "250 OK\n" }
  localhost.cmd('signal NEWNYM') { |c| print c; throw "Cannot switch Tor to new route" if c != "250 OK\n" }
  localhost.close
  sleep 5

  hi = Mechanize.new.get("http://www.socialserve.com/dbh/ViewUnit/404032?hm=x193T2DZ").content

  puts hi

  new_ip = Mechanize.new.get("http://bot.whatismyipaddress.com").content
  puts "new IP is #{new_ip}"
end
