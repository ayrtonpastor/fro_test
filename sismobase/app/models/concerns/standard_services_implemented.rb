# frozen_string_literal: true

module StandardServicesImplemented
  extend ActiveSupport::Concern

  included do
    def self.services_available
      self::STANDARD_SERVICES_AVAILABLE
    rescue StandardError
      [{ actor_name: 'creator', so_prefix: 'create' },
       { actor_name: 'updater', so_prefix: 'update' },
       { actor_name: 'informer', so_prefix: 'info' },
       { actor_name: 'destroyer', so_prefix: 'destroy' },
       { actor_name: 'querier', so_prefix: 'query', pluralize_subfix: true }].freeze
    end

    services_available.each do |service|
      singleton_class.instance_eval do
        # the creation of the services methods must be AFTER the method 'services_availables' that defines the services for the class.
        define_method(service[:actor_name]) do |_arg = nil|
          names_array = name.split('::')
          class_name = names_array.pop
          names_array.push class_name.pluralize
          names_array.push("#{service[:so_prefix].classify}#{service[:pluralize_subfix] ? class_name.pluralize : class_name}")
          "::#{names_array.join('::')}".constantize
        end
      end

      # Métodos para acceder a una instancia de cada SO.
      define_method("#{service[:actor_name]}_so") do |_arg = nil|
        initializer_params = case service[:actor_name]
                             when 'creator'
                               [{}]
                             when 'updater'
                               [self, {}]
                             when 'informer'
                               [self]
                             when 'destroyer'
                               [self]
                             else
                               []
                             end
        self.class.send(service[:actor_name]).new(*initializer_params)
      end
    end
  end
end
