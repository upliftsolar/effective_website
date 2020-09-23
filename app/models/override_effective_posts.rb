require 'effective_posts'
class ::Effective::Post
  has_many :attachments
end
class OverrideEffectivePosts
  #TODO: use autoloads.
end