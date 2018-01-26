require 'bundler'
require 'terminal-table'
require 'colorize'
#require 'command_line_reporter'
require 'colorized_string'
require 'artii'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = false
require_all 'lib'
require_all 'app'

# Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
