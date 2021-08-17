# elochat

Replacement chat server for Elona and its variants. Includes Discord webhook support.

Currently hosted at `elochat.yeek.agency`.

## Usage

Set the `serverList` option in `config.txt` to `1`, then create a file named `server.txt` with these contents:

```
elochat.yeek.agency%elochat.yeek.agency%
```

## Deployment

```
bundle exec rake db:reseed
bundle exec rackup -o 0.0.0.0 -p 9292 -s webrick -E development -d -w
```

See `elochat.service` for additional configuration options.

## Notes

When adding a DNS record pointing to the server, you have to prepend `www.` to the beginning of the host because of a backwards compatibility issue (the original code prepends it to the configured server name). So `elochat.ruin.xyz` would become `www.elochat.ruin.xyz`.
