# encoding: utf-8

title 'vpc'

estate_name       = attribute('estate_name')
stack_name        = attribute('stack_name')
environment_name  = attribute('environment_name')

describe aws_ec2_instance(name: "appserver-#{stack_name}-#{environment_name}-#{estate_name}") do
  it { should be_running }
end
