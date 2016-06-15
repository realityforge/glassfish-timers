require 'dbt'

Dbt.add_database(:default) do |database|
  database.version = '1'
  database.search_dirs = %w(database)
end
