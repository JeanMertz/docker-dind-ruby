require 'archive/tar/minitar'
require 'docker'
require 'excon'
require 'json'
require 'serverspec'

set :backend, :docker

Excon.defaults[:ssl_verify_peer] = false

Docker.options = { read_timeout: 600, write_timeout: 600 }

RSpec.configure do |config|
  dir = File.dirname(__FILE__)
  image_name = File.basename(File.dirname(dir)).sub('docker-', '')
  config.add_setting :docker_image_name, default: "blendle/#{image_name}:test"

  config.before(:suite) do
    puts 'preparing new Docker image for testing...'

    files = Dir.glob('*').reject { |f| f.include?('vendor') }
    tmp   = Tempfile.new(SecureRandom.urlsafe_base64)

    Archive::Tar::Minitar.pack(files, tmp, true)
    tar = File.new(tmp.path, 'r')

    img = Docker::Image.build_from_tar(tar, t: config.docker_image_name) do |l|
      $stdout.print JSON.parse(l)['stream']
    end

    config.docker_image = img.id
  end

  config.docker_container_create_options = {
    'HostConfig' => {
      'Privileged' => true
    }
  }
end

Docker.options = { read_timeout: 60, write_timeout: 60 }
