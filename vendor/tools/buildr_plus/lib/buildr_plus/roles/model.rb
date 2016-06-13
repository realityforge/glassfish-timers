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

BuildrPlus::Roles.role(:model) do
  if BuildrPlus::FeatureManager.activated?(:domgen)
    generators = [:ee_data_types]
    if BuildrPlus::FeatureManager.activated?(:db)
      generators << [:jpa_orm_xml, :jpa_model, :jpa_ejb_dao]
      generators << [:jpa_persistence_xml] if BuildrPlus::Artifacts.is_model_standalone?

      generators << [:jpa_ejb_dao] if BuildrPlus::FeatureManager.activated?(:ejb)

      generators << [:imit_server_entity_listener] if BuildrPlus::FeatureManager.activated?(:replicant)
    end

    generators << [:jaxb_marshalling_tests, :xml_xsd_resources] if BuildrPlus::FeatureManager.activated?(:xml)

    if BuildrPlus::Roles.buildr_projects_with_role(:shared).size == 0
      generators << [:appconfig_feature_flag_container] if BuildrPlus::FeatureManager.activated?(:appconfig)
      generators << [:syncrecord_datasources] if BuildrPlus::FeatureManager.activated?(:syncrecord)
    end

    generators += project.additional_domgen_generators

    Domgen::Build.define_generate_task(generators.flatten, :buildr_project => project)
  end

  project.publish = BuildrPlus::Artifacts.model?

  compile.using :javac
  compile.with BuildrPlus::Libs.ee_provided

  # Our JPA beans are occasionally generated with eclipselink specific artifacts
  compile.with BuildrPlus::Libs.glassfish_embedded if BuildrPlus::FeatureManager.activated?(:db)

  compile.with BuildrPlus::Deps.model_deps

  BuildrPlus::Roles.merge_projects_with_role(project.compile, :shared)

  package(:jar)
  package(:sources)

  if BuildrPlus::FeatureManager.activated?(:db)

    check package(:jar), 'should contain resources and generated classes' do
      it.should contain('META-INF/orm.xml')
      if BuildrPlus::Artifacts.is_model_standalone?
        it.should contain('META-INF/persistence.xml')
      else
        it.should_not contain('META-INF/persistence.xml')
      end
    end

    iml.add_jpa_facet
    iml.add_ejb_facet if BuildrPlus::FeatureManager.activated?(:ejb)
  end
end
