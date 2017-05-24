class Buildr::Project
  def package_as_json(file_name)
    file(file_name)
  end

  def package_as_json_sources_spec(spec)
    spec.merge(:type => :json, :classifier => :sources)
  end

  def package_as_json_sources(file_name)
    file(file_name)
  end
end

require 'buildr/git_auto_version'
require 'buildr/bnd'
require 'buildr/gpg'
require 'buildr/activate_jruby_facet'
require 'buildr/single_intermediate_layout'

desc 'GlassfishTimers: GlassFish timers database sql'
define 'glassfish-timers' do
  project.group = "org.realityforge.glassfish.timers#{ENV['DB_TYPE'] == 'pg' ? '.pg' : ''}"
  compile.options.source = '1.8'
  compile.options.target = '1.8'

  pom.add_apache_v2_license
  pom.add_github_project('realityforge/glassfish-timers')
  pom.add_developer('realityforge', 'Peter Donald', 'peter@realityforge.org', ['Developer'])

  define 'db' do
    project.no_iml
    Dbt.define_database_package(:default)
  end

  define 'domain' do
    project.no_iml
    json = File.dirname(__FILE__) + '/src/main/etc/redfish-' + (ENV['DB_TYPE'] == 'pg' ? 'pgsql' : 'mssql') + '.json'
    package(:json).enhance do |t|
      FileUtils.mkdir_p File.dirname(t.to_s)
      FileUtils.cp json, t.to_s
    end
    package(:json_sources).enhance do |t|
      FileUtils.mkdir_p File.dirname(t.to_s)
      FileUtils.cp json, t.to_s
    end
    package(:sources).tap do |t|
      t.include json
    end
  end
end
