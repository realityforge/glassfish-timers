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
require 'buildr/gpg'
require 'buildr/single_intermediate_layout'

Buildr::MavenCentral.define_publish_tasks(:profile_name => 'org.realityforge', :username => 'realityforge')

desc 'GlassfishTimers: GlassFish timers database sql'
define 'glassfish-timers' do
  project.group = "org.realityforge.glassfish.timers#{ENV['DB_TYPE'] == 'pg' ? '.pg' : ''}"
  compile.options.source = '17'
  compile.options.target = '17'

  project.version = ENV['PRODUCT_VERSION'] if ENV['PRODUCT_VERSION']

  pom.add_apache_v2_license
  pom.add_github_project('realityforge/glassfish-timers')
  pom.add_developer('realityforge', 'Peter Donald')

  define 'db' do
    project.no_iml
    doc_dir = doc.target.to_s
    file(doc_dir) do
      FileUtils.mkdir_p doc_dir
    end
    Dbt.define_database_package(:default)
    package(:javadoc)
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
