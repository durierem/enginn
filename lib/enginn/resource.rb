# frozen_string_literal: true

module Enginn
  class Resource
    HTTP_VERBS = %i[get post patch delete].freeze

    class << self
      def resource(resource_name, only: HTTP_VERBS)
        [only].flatten.each do |http_method|
          send("define_#{http_method}", resource_name)
        end
      end

      protected

      def define_get(resource_name)
        define_singleton_method('get') do |id = nil|
          Enginn.request(:get, resource_name, id: id)
        end
      end

      def define_post(resource_name)
        define_singleton_method('post') do |attributes|
          Enginn.request(:post, resource_name, attributes: attributes)
        end
      end

      def define_patch(resource_name)
        define_singleton_method('patch') do |id, attributes|
          Enginn.request(:patch, resource_name, id: id, attributes: attributes)
        end
      end

      def define_delete(resource_name)
        define_singleton_method('delete') do |id|
          Enginn.request(:delete, resource_name, id: id)
        end
      end
    end
  end
end
