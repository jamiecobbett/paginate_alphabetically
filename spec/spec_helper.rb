$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

require 'active_support'
require 'active_record'
require 'action_view'

include ActionView::Helpers
require File.expand_path(File.join(File.dirname(__FILE__), '../init.rb'))

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

load File.expand_path(File.join(File.dirname(__FILE__), 'db/schema.rb'))

class Thing < ActiveRecord::Base
  paginate_alphabetically :by => :name
end

class Numpty < ActiveRecord::Base
end
