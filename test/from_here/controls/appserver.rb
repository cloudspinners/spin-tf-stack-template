# encoding: utf-8

title 'appserver'

appserver_ip      = attribute('appserver_ip')
estate_name       = attribute('estate_name')
stack_name        = attribute('stack_name')
environment_name  = attribute('environment_name')

identifier = "#{stack_name}-#{environment_name}-#{estate_name}"

describe http("http://#{appserver_ip}:8080/") do
  its('status') { should eq 200 }
  its('body') { should match /#{identifier}/ }
end
