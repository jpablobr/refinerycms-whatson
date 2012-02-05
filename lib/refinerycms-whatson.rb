require 'filters_spam'

module Refinery
  module Whatson
    autoload :Version, File.expand_path('../refinery/whatson/version', __FILE__)
    autoload :Tab, File.expand_path("../refinery/whatson/tabs", __FILE__)

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end

      def version
        ::Refinery::Whatson::Version.to_s
      end
    end

    class Engine < Rails::Engine
      initializer 'whatson serves assets' do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        require File.expand_path('../refinery/whatson/tabs', __FILE__)
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_whatson"
          plugin.url = {:controller => '/admin/whatson/posts', :action => 'index'}
          plugin.menu_match = /^\/?(admin|refinery)\/whatson\/?(posts|comments|categories)?/
          plugin.activity = {
            :class => WhatsonPost
          }
        end
      end
    end if defined?(Rails::Engine)
  end
end
