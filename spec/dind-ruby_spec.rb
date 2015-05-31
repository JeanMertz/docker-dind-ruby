require 'spec_helper'

ruby_version = '2.1.3'

describe RSpec.configuration.docker_image_name do
  describe command('ruby --version') do
    its(:stdout) { is_expected.to include("ruby #{ruby_version}") }
  end

  describe file("/opt/rubies/ruby-#{ruby_version}/etc/gemrc") do
    its(:content) { is_expected.to include('gem: --no-document') }
  end

  describe command('command -v bundle') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('command -v ruby-install') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('docker version') do
    its(:stdout) { is_expected.to include('Client version: 1.6.2') }
    its(:stdout) { is_expected.to include('Server version: 1.6.2') }
  end
end
