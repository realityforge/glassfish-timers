require 'buildr/gpg'
require 'buildr/custom_pom'
require 'buildr_plus/java_library_multimodule'
BuildrPlus::Dbt.library = false

class Buildr::Project
  def package_as_json(file_name)
    file(file_name)
  end
end

BuildrPlus::Roles.project('glassfish-timers') do
  project.comment = 'GlassfishTimers: GlassFish timers database sql'
  project.group = 'org.realityforge.glassfish.timers'

  pom.add_apache_v2_license
  pom.add_github_project('realityforge/glassfish-timers')
  pom.add_developer('realityforge', 'Peter Donald', 'peter@realityforge.org', ['Developer'])

  define 'domain' do
    project.no_iml
    package(:json).enhance do |t|
      FileUtils.mkdir_p File.dirname(t.to_s)
      FileUtils.cp File.dirname(__FILE__) + '/src/main/etc/redfish.json', t.to_s
    end
  end
end

require 'buildr_plus/activate'
