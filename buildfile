require 'buildr/gpg'
require 'buildr/custom_pom'
require 'buildr_plus/java_library_multimodule'

BuildrPlus::Roles.project('glassfish-timers') do
  project.comment = 'GlassfishTimers: GlassFish timers database sql'
  project.group = 'org.realityforge.glassfish.timers'

  pom.add_apache_v2_license
  pom.add_github_project('realityforge/glassfish-timers')
  pom.add_developer('realityforge', 'Peter Donald', 'peter@realityforge.org', ['Developer'])
end

require 'buildr_plus/activate'
