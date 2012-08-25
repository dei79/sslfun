module SslFun
  class Certificate < ActiveRecord::Base
    # set the table name
    self.table_name=  'ssl_fun_certificates'

    # accessor
    attr_accessible :data, :key_pair

    # associations
    belongs_to :key_pair, :class_name => 'SslFun::KeyPair', :inverse_of => :certificates

    # validates
    validates :data, :presence => true, :uniqueness => true

    # read the certificate
    def to_x509!
      OpenSSL::X509::Certificate.new(self.data)
    end

    def to_x509
      begin
        to_x509!
      rescue
        nil
      end
    end

    # convert to pem
    def to_pem
      self.data
    end

    #
    # This method allows to generate a PKCS12 files and supports the following
    # call types
    #
    # .to_p12! :password => "YourPassword", :display => "Your User Friendly Display Name"
    #
    def to_p12!(options = {})
      raise "Missing key pair to generate the PKCS12 file" unless self.key_pair

      pkey = key_pair.to_x509
      cert = self.to_x509!

      password = options[:password]
      password = "test" unless password

      friendly_key = options[:display]
      friendly_key = "key" unless friendly_key

      # generate
      OpenSSL::PKCS12::create(password, friendly_key, pkey, cert)
    end

    #
    # This method allows to generate a PKCS12 files and supports the following
    # call types
    #
    # .to_p12 :password => "YourPassword", :display => "Your User Friendly Display Name"
    #
    def to_p12(options = {})
      begin
        to_p12!(options)
      rescue
        nil
      end
    end

    #
    # The serial number of the issued certificate
    #
    def serial
      if to_x509
        to_x509.serial
      else
        0
      end
    end

  end
end
