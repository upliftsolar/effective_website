for dir in Dir.glob("app/assets/stylesheets/fonts/*")
  Rails.application.config.assets.paths << Rails.root.join(dir)
end
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
Rails.application.config.assets.precompile += %w( barrio.css uplift.css )