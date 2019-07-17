# encoding: utf-8

title 'vpc'

estate_name       = attribute('estate_name')
stack_name        = attribute('stack_name')
environment_name  = attribute('environment_name')

describe aws_vpc_list do
  its('name') { should include "vpc-#{stack_name}-#{environment_name}-#{estate_name}" }
end
