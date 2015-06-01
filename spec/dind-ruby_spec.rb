require 'spec_helper'

describe RSpec.configuration.docker_image_name do
  describe command('command -v socat') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('command -v perl') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('command -v nproc') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('docker version') do
    its(:stdout) { is_expected.to include('Client version: 1.6.2') }
    its(:stdout) { is_expected.to include('Server version: 1.6.2') }
  end
end
