# blendle/dind-ruby [![Build Status](http://drone.blendle.io/api/badge/github.com/blendle/docker-dind-ruby/status.svg?branch=master)](http://drone.blendle.io/github.com/blendle/docker-dind-ruby)


Wrapper around the [jpetazzo/dind][] Docker image.

This image has Ruby pre-installed. It also comes with the Bundler gem installed
and sane Bundler configuration values.

## Ruby version

The default Ruby version packaged in this image is `2.1.3`.

`ruby-install` comes pre-installed in the image, so installing a new Ruby
version is easy:

```docker
RUN ruby-install ruby 2.2.1
```

Note that `PATH` by default points to the default Ruby version. You can either
install a ruby version manager (like [chruby][]), or alter the path:

```docker
ENV PATH /opt/rubies/ruby-2.2.1/bin:$PATH

# PATH:
# - /opt/rubies/ruby-2.2.1/bin
# - /usr/local/sbin
# - /usr/local/bin
# - /usr/sbin
# - /usr/bin
# - /sbin
# - /bin
# - /opt/rubies/ruby-2.1.3/bin
```

Be sure to *prepend* the new path, or else the default Ruby version will take
precedence.

[jpetazzo/dind]: https://github.com/jpetazzo/dind
[chruby]: https://github.com/postmodern/chruby

## License

MIT - see the accompanying [LICENSE](LICENSE) file for details.
