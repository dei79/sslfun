#
# This file contains everything which is needed to manipulate Active Record models
#
module SslFun
  module Models

    module ClassMethods

      #
      # This function configures the given attributes as a ssl fun certificate
      #
      def sslfun_certificate(*attributes)
        # check the attributes
        attributes.each() do |attrib|
          belongs_to attrib, :class_name => 'SslFun::Certificate', :dependent => :destroy
        end
      end

      #
      # This function configures the given attributes as a ssl fun key pair. There a several options
      # to use this functions
      #
      # sslfun_keypair :app_key                         => A normal relation
      # sslfun_keypair :app_key, :auto_generate => true => A new key pair will be generated when ever an object is initialized
      #
      def sslfun_keypair(*attributes)
        # generate the options hashe
        options = attributes.extract_options!

        attributes.each() do |attrib|
          # set the belongs to info
          belongs_to attrib, :class_name => 'SslFun::KeyPair', :dependent => :destroy

          # set the after_initialize callback if needed
          if options[:auto_generate]
            self.send :after_initialize, :autogenerate_new_key_pair
          end
        end
      end
    end

    module InstanceMethods

      def autogenerate_new_key_pair
        self.app_key = SslFun::KeyPair.new unless self.app_key
      end

    end

  end
end

# Extend all models through a couple class methods
ActiveRecord::Base.send :extend, SslFun::Models::ClassMethods
ActiveRecord::Base.send :include, SslFun::Models::InstanceMethods
