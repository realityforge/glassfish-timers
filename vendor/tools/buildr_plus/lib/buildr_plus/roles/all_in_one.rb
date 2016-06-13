#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BuildrPlus::Roles.role(:all_in_one) do
  project.publish = true

  if BuildrPlus::FeatureManager.activated?(:domgen)
    generators = [:ee_data_types, :ee_web_xml, :ee_beans_xml]
    if BuildrPlus::FeatureManager.activated?(:db)
      generators << [:jpa]
      generators << [:jpa_test_qa, :jpa_test_qa_external, :jpa_ejb_dao, :jpa_dao_test] if BuildrPlus::FeatureManager.activated?(:ejb)
      generators << [:jpa_test_orm_xml, :jpa_test_persistence_xml] unless BuildrPlus::Artifacts.is_model_standalone?
      generators << [:imit_server_entity_listener, :imit_server_entity_replication] if BuildrPlus::FeatureManager.activated?(:replicant)
    end

    generators << [:gwt_rpc_shared, :gwt_rpc_server] if BuildrPlus::FeatureManager.activated?(:gwt)
    generators << [:imit_shared, :imit_server_service, :imit_server_qa] if BuildrPlus::FeatureManager.activated?(:replicant)

    if BuildrPlus::FeatureManager.activated?(:sync)
      if BuildrPlus::Sync.standalone?
        generators << [:sync_ejb]
      else
        generators << [:sync_core_ejb]
      end
    end

    generators << [:ee_messages, :ee_exceptions, :ejb_service_facades, :ejb_test_qa_external, :ee_filter, :ejb_test_qa, :ejb_test_service_test] if BuildrPlus::FeatureManager.activated?(:ejb)

    generators << [:jaxb_marshalling_tests, :xml_xsd_resources, :xml_public_xsd_webapp] if BuildrPlus::FeatureManager.activated?(:xml)
    generators << [:jws_server, :ejb_glassfish_config_assets] if BuildrPlus::FeatureManager.activated?(:soap)

    generators << [:jms] if BuildrPlus::FeatureManager.activated?(:jms)
    generators << [:jaxrs] if BuildrPlus::FeatureManager.activated?(:jaxrs)
    generators << [:mail_mail_queue, :mail_test_module] if BuildrPlus::FeatureManager.activated?(:mail)

    generators += project.additional_domgen_generators

    Domgen::Build.define_generate_task(generators.flatten, :buildr_project => project)
  end

  compile.with BuildrPlus::Libs.ee_provided
  compile.with BuildrPlus::Libs.glassfish_embedded if BuildrPlus::FeatureManager.activated?(:soap) || BuildrPlus::FeatureManager.activated?(:db)

  compile.with artifacts(Object.const_get(:PACKAGED_DEPS)) if Object.const_defined?(:PACKAGED_DEPS)
  compile.with BuildrPlus::Deps.model_deps
  compile.with BuildrPlus::Deps.server_deps

  test.with BuildrPlus::Libs.guiceyloops,
            BuildrPlus::Libs.db_drivers
  test.with BuildrPlus::Deps.model_qa_support_deps

  package(:war).tap do |war|
    war.libs.clear
    war.libs << artifacts(Object.const_get(:PACKAGED_DEPS)) if Object.const_defined?(:PACKAGED_DEPS)
    war.libs << BuildrPlus::Deps.model_deps
    war.libs << BuildrPlus::Deps.server_deps
    war.exclude project.less_path if BuildrPlus::FeatureManager.activated?(:less)
    if BuildrPlus::FeatureManager.activated?(:sass)
      project.sass_paths.each do |sass_path|
        war.exclude project._(sass_path)
      end
    end
    war.include assets.to_s, :as => '.' if BuildrPlus::FeatureManager.activated?(:gwt) || BuildrPlus::FeatureManager.activated?(:less) || BuildrPlus::FeatureManager.activated?(:sass)
  end

  check package(:war), 'should contain generated gwt artifacts' do
    it.should contain("#{project.root_project.name}/#{project.root_project.name}.nocache.js")
  end if BuildrPlus::FeatureManager.activated?(:gwt) && BuildrPlus::FeatureManager.activated?(:user_experience)
  check package(:war), 'should contain web.xml' do
    it.should contain('WEB-INF/web.xml')
  end
  check package(:war), 'should not contain less files' do
    it.should_not contain('**/*.less')
  end if BuildrPlus::FeatureManager.activated?(:less)
  check package(:war), 'should not contain sass files' do
    it.should_not contain('**/*.sass')
  end if BuildrPlus::FeatureManager.activated?(:sass)

  iml.add_jpa_facet if BuildrPlus::FeatureManager.activated?(:db)
  iml.add_ejb_facet if BuildrPlus::FeatureManager.activated?(:ejb)

  webroots = {}
  webroots[_(:source, :main, :webapp)] = '/'
  webroots[_(:source, :main, :webapp_local)] = '/' if BuildrPlus::FeatureManager.activated?(:gwt)
  assets.paths.each do |path|
    next if path.to_s =~ /generated\/gwt\// && BuildrPlus::FeatureManager.activated?(:gwt)
    next if path.to_s =~ /generated\/less\// && BuildrPlus::FeatureManager.activated?(:less)
    next if path.to_s =~ /generated\/sass\// && BuildrPlus::FeatureManager.activated?(:sass)
    webroots[path.to_s] = '/'
  end
  iml.add_web_facet(:webroots => webroots)

  default_testng_args = []
  default_testng_args << '-ea'
  default_testng_args << '-Xmx2024M'
  default_testng_args << '-XX:MaxPermSize=364M'

  if BuildrPlus::FeatureManager.activated?(:db)
    default_testng_args << "-javaagent:#{Buildr.artifact(BuildrPlus::Libs.eclipselink).to_s}"

    if BuildrPlus::FeatureManager.activated?(:dbt)
      old_environment = Dbt::Config.environment
      begin
        Dbt.repository.load_configuration_data

        Dbt.database_keys.each do |database_key|
          database = Dbt.database_for_key(database_key)
          next unless database.enable_rake_integration? || database.packaged? || !database.managed?
          next if BuildrPlus::Dbt.manual_testing_only_database?(database_key)

          prefix = Dbt::Config.default_database?(database_key) ? '' : "#{database_key}."
          database = Dbt.configuration_for_key(database_key, :test)
          default_testng_args << "-D#{prefix}test.db.url=#{database.build_jdbc_url(:credentials_inline => true)}"
          default_testng_args << "-D#{prefix}test.db.name=#{database.catalog_name}"
        end
      ensure
        Dbt::Config.environment = old_environment
      end
    end
  end

  default_testng_args.concat(BuildrPlus::Glassfish.addtional_default_testng_args)

  ipr.add_default_testng_configuration(:jvm_args => default_testng_args.join(' '))

  dependencies = [project]
  dependencies << Object.const_get(:PACKAGED_DEPS) if Object.const_defined?(:PACKAGED_DEPS)
  dependencies << BuildrPlus::Deps.model_deps
  dependencies << BuildrPlus::Deps.server_deps

  war_module_names = [project.iml.name]
  jpa_module_names = BuildrPlus::FeatureManager.activated?(:db) ? [project.iml.name] : []
  ejb_module_names =
    BuildrPlus::FeatureManager.activated?(:db) || BuildrPlus::FeatureManager.activated?(:ee) ? [project.iml.name] : []

  ipr.add_exploded_war_artifact(project,
                                :dependencies => dependencies,
                                :war_module_names => war_module_names,
                                :jpa_module_names => jpa_module_names,
                                :ejb_module_names => ejb_module_names)

  remote_packaged_apps = BuildrPlus::Glassfish.remote_only_packaged_apps.dup.merge(BuildrPlus::Glassfish.packaged_apps)
  local_packaged_apps = BuildrPlus::Glassfish.non_remote_only_packaged_apps.dup.merge(BuildrPlus::Glassfish.packaged_apps)

  local_packaged_apps['greenmail'] = BuildrPlus::Libs.greenmail_server if BuildrPlus::FeatureManager.activated?(:mail)

  ipr.add_glassfish_remote_configuration(project,
                                         :server_name => 'Payara 4.1.1.154',
                                         :exploded => [project.name],
                                         :packaged => remote_packaged_apps)
  ipr.add_glassfish_configuration(project,
                                  :server_name => 'Payara 4.1.1.154',
                                  :exploded => [project.name],
                                  :packaged => local_packaged_apps)

  if local_packaged_apps.size > 0
    ipr.add_glassfish_configuration(project,
                                    :configuration_name => "#{BuildrPlus::Naming.pascal_case(project.name)} Only - Payara 4.1.1.154",
                                    :server_name => 'Payara 4.1.1.154',
                                    :exploded => [project.name])
  end
end
