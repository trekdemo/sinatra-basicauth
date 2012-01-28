spec = Gem::Specification.new do |s|
  s.name = 'sinatra-basicauth'
  s.version = '0.0.1'
  s.date = '2012-01-28'
  s.summary = 'Simple basic auth helper for Sinatra'
  s.description = s.summary

  s.homepage = "http://github.com/trekdemo/sinatra-basicauth"

  s.authors = ["Gergo Sulymosi"]
  s.email = "gergo.sulymosi@gmail.com"

  s.add_dependency('rack')
  s.has_rdoc = false

  s.files         = `git ls-files`.split("\n").sort
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
