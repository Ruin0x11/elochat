# elochat

Replacement chat server for Elona and its variants. Includes Discord webhook support.

## Usage

```
bundle exec rake db:reseed
bundle exec rackup -o 0.0.0.0 -p 9292 -s webrick -E development -d -w
```

See `elochat.service` for additional configuration options.
