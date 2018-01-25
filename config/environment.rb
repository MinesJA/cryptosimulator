require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = false
require_all 'lib'
require_all 'app'

# Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
