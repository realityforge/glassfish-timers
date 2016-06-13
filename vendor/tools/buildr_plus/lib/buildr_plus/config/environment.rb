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

module BuildrPlus #nodoc
  module Config #nodoc
    class EnvironmentConfig < BuildrPlus::BaseElement
      def initialize(key, options = {}, &block)
        options = options.dup

        @key = key

        @databases = {}
        @settings = {}

        (options.delete('databases') || {}).each_pair do |database_key, config|
          database(database_key, config)
        end

        ssrs = options.delete('ssrs')
        ssrs(ssrs) if ssrs

        (options.delete('settings') || {}).each_pair do |setting_key, value|
          setting(setting_key, value)
        end

        broker_config = options.delete('broker')
        broker(broker_config) if broker_config

        super(options, &block)
      end

      attr_reader :key

      def setting(key, value)
        raise "Attempting to redefine stting with key '#{key}'." if @settings[key.to_s]
        @settings[key.to_s] = value.to_s
      end

      def setting?(key)
        !!@settings[key.to_s]
      end

      def settings
        @settings.dup
      end

      def database_by_key?(key)
        !!@databases[key.to_s]
      end

      def database_by_key(key)
        raise "Attempting to retrieve database with key '#{key}' but no such database exists." unless @databases[key.to_s]
        @databases[key.to_s]
      end

      def databases
        @databases.values
      end

      def database(key, config = {}, &block)
        raise "Attempting to redefine database with key '#{key}'." if @databases[key.to_s]
        config = config.dup

        dialect = config.delete('driver') || (BuildrPlus::Db.mssql? ? 'sql_server' : 'postgres')
        type = dialect == 'sql_server' ? BuildrPlus::Config::MssqlDatabaseConfig : BuildrPlus::Config::PostgresDatabaseConfig
        @databases[key.to_s] = type.new(key, config, &block)
      end

      def ssrs?
        !@ssrs.nil?
      end

      def ssrs(options = {}, &block)
        if @ssrs.nil?
          @ssrs = BuildrPlus::Config::SsrsConfig.new(options, &block)
        else
          @ssrs.options = options
          yield @ssrs if block_given?
        end
        @ssrs
      end

      def broker?
        !@broker.nil?
      end

      def broker(options = {}, &block)
        if @broker.nil?
          @broker = BuildrPlus::Config::BrokerConfig.new(options, &block)
        else
          @broker.options = options
          yield @broker if block_given?
        end
        @broker
      end

      def to_h
        results = {}
        dbs = self.databases
        if dbs.size > 0
          results['databases'] = {}
          dbs.each do |db|
            results['databases'][db.key] = db.to_h
          end
        end
        results['ssrs'] = self.ssrs.to_h if self.ssrs?
        results['settings'] = self.settings unless self.settings.empty?
        results['broker'] = self.broker.to_h if self.broker?
        results
      end
    end
  end
end
