require "active_model/forbidden_attributes_protection"

module Domain
  module Shared

    # Mixin that enables objects to be initialized from a data object. Data
    # objects respond to either to_h or to_json:
    #   * Hash
    #   * ActiveRecord object
    #   * OpenStruct
    #   * Params hash
    #
    # When given a rails params hash, it ensures that it has been sanitized
    # for mass assignment. If not it raises an ActiveModel::ForbiddenAttributes
    # exception.
    module InitializeFromDataObject
      def initialize(data_object = {})
        data_object = convert_from_json_string(data_object)

        if !data_object.respond_to?(:permitted?) || data_object.permitted?
          set_instance_variables(data_object)
        else
          raise ActiveModel::ForbiddenAttributes
        end
      end

      private

      def convert_from_json_string(data_object)
        if data_object.is_a?(String)
          OpenStruct.new(JSON.parse(data_object))
        else
          data_object
        end
      end

      def set_instance_variables(data_object)
        hash = convert_to_hash(data_object)
        hash.each do |k,v|
          instance_variable_set("@#{k}".to_sym, v)
        end
      end

      def convert_to_hash(data_object)
        if data_object.respond_to?(:to_h)
          data_object.to_h
        elsif data_object.respond_to?(:as_json)
          data_object.as_json
        end
      end
    end
  end
end
