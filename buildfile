require 'buildr_plus/java_library_multimodule'

BuildrPlus::Roles.project('glassfish-timers') do
  project.comment = 'GlassfishTimers: GlassFish timers database sql'
  project.group = 'org.realityforge.glassfish.timers'
end

require 'buildr_plus/activate'
