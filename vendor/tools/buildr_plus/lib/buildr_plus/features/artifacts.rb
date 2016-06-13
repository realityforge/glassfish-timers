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

BuildrPlus::FeatureManager.feature(:artifacts) do |f|
  f.enhance(:Config) do

    attr_writer :publish

    def publish?
      @publish.nil? ? true : !!@publish
    end

    attr_writer :library

    def library?
      @library.nil? ? false : !!@library
    end

    attr_writer :model

    def model?
      @model.nil? ? library? : !!@model
    end

    attr_writer :is_model_standalone

    def is_model_standalone?
      @is_model_standalone.nil? ? !BuildrPlus::Dbt.library? : !!@is_model_standalone
    end

    attr_writer :gwt

    def gwt?
      @gwt.nil? ? library? : !!@gwt
    end

    attr_writer :db

    def db?
      @db.nil? ? true : !!@db
    end

    attr_writer :war

    def war?
      @war.nil? ? true : !!@war
    end
  end
  f.enhance(:ProjectExtension) do
    after_define do |project|
      project.publish = false unless BuildrPlus::Artifacts.publish?
    end
  end
end
