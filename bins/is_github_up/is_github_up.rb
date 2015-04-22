#!/usr/bin/env ruby
require 'net/http'
require 'json'

res = Net::HTTP.get_response(URI.parse('https://status.github.com/api/status.json'))

if res.code != '200'
  puts "\033[31munable to reach GitHub\033[0m"
  exit 1
end

status = JSON.parse(res.body)['status']

if status == 'good'
  print "\033[32myes"
elsif status == 'minor'
  print "\033[33mminor issues"
else
  print "\033[31mno"
end
puts "\033[0m"
