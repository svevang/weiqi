# weiqi-chef-cookbook

This is a vagrant-chef setup used to bootstrap weiqi for development.
Included is a selenium stand alone server that is managed by a
supervisor process.

## Testing

Make sure you have ChefDK installed and run `kitchen test`

## Supported Platforms

Ubuntu 14.04

## Attributes

None yet, but a possible TODO is the download url for selenium could be
pulled out here.

## Usage

### weiqi-chef::default

Include `weiqi-chef` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[weiqi-chef::default]"
  ]
}
```

## License and Authors

Author:: Sam Vevang <sam.vevang@gmail.com>
