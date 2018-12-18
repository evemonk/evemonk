const { environment } = require('@rails/webpacker')
const erb =  require('./loaders/erb')
const vue =  require('./loaders/vue')

environment.loaders.append('vue', vue)
environment.loaders.append('erb', erb)
module.exports = environment
