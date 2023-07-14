#!/usr/bin/env ruby
# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup"
require "sshkit"

include SSHKit::DSL

host = SSHKit::Host.new("root@evemonk.com")

on host do |_|
  within "/root/docker/evemonk-backend" do
    execute :docker, :compose, :pull
    execute :docker, :compose, :down
    execute :docker, :compose, "up -d"
  end
end
