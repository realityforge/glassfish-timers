require 'dbt'

Dbt::Config.driver = 'postgres' if ENV['DB_TYPE'] == 'pg'

Dbt.add_database(:default) do |database|
  database.version = '1'
  database.search_dirs = %W(database/#{ENV['DB_TYPE'] == 'pg' ? 'pg' : 'mssql'})
end
