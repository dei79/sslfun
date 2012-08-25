class App < ActiveRecord::Base
  # set the accessors
  attr_accessible :app_cert_id, :app_key_id, :name

  # relations
  sslfun_certificate  :app_cert
  sslfun_keypair      :app_key, :auto_generate => true

  # validations
  validates :name, :presence => true



end
