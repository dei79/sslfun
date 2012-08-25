$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ssl_fun/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sslfun"
  s.version     = SslFun::VERSION
  s.authors     = ["Dirk Eisenberg"]
  s.email       = ["dirk.eisenberg@gmail.com"]
  s.homepage    = "https://github.com/dei79/sslfun"
  s.summary     = "Small rails engine which makes it simple to work with certificates, keys and csr's."
  s.description = "Small rails engine which makes it simple to work with ceritficates, keys and csr's. It allows to " +
                  "create new key pairs and csrs. The signed certificates can be imported back into the application. " +
                  "All is stored in your rails data model"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
