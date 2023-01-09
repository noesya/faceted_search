$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "faceted_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "faceted_search"
  spec.version     = FacetedSearch::VERSION
  spec.authors     = ["Arnaud Levy", "Sébastien Gaya", "Sébastien Moulène"]
  spec.email       = ["arnaud.levy@noesya.coop", "sebastien.gaya@gmail.com", "sebousan@gmail.com"]
  spec.homepage    = "http://github.com/noesya/faceted_search"
  spec.summary     = "Faceted search with Active Record"
  spec.description = "All you need to create a faceted search, as simple as possible"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rails', '>= 5.2.0'
  spec.add_dependency 'font-awesome-sass'

  spec.add_development_dependency "pg"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "bootstrap"
  spec.add_development_dependency "kaminari"
  spec.add_development_dependency "font-awesome-sass"
end
