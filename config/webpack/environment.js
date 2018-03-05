const { environment } = require('@rails/webpacker')

environment.loaders.append('json', {
  test: /\.json$/,
  use: 'json-loader'
})

environment.loaders.append('yaml', {
  test: /\.yml$/,
  use: 'yaml-loader'
})

module.exports = environment
