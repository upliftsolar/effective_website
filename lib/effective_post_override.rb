require 'effective_posts'
Effective::Post.module_eval do
  def self.position
    (ENV["POSTS_POSITION"] || 25).to_i
  end
end