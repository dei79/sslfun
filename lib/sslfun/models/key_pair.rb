module SslFun
  class KeyPair < ActiveRecord::Base
    # set the table name
    self.table_name=  'ssl_fun_key_pairs'

    # associations
    has_many :certificates, :class_name => 'SslFun::Certificate', :inverse_of => :key_pair, :dependent => :destroy

    # validate
    validates :data, :presence => true, :uniqueness => true

    # attribute accessors
    attr_accessible :data

    # handler
    after_initialize :generate_new_key

    # generates a new private key if needed
    def generate_new_key
      self.data = OpenSSL::PKey::RSA.new(2048).to_pem unless self.data
    end

    def to_x509!
      OpenSSL::PKey::RSA.new(self.data)
    end

    def to_pem!
      to_x509!.to_pem
    end

    def to_sha1_hash!
      Digest::SHA1.hexdigest(self.to_pem!)
    end

    def generate_csr!(subject_name)
      SslFun::Csr.new(:key => self, :subject => subject_name)
    end

  end
end
