Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets","fonts","HaasGrotDisp-35Thin")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets","fonts","HaasGrotDisp-45Light")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets","fonts","HaasGrotDisp-65Medium")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "stylesheets","fonts","Apercu")
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
Rails.application.config.assets.precompile += %w( barrio.css uplift.css )