require 'effective_posts'
class ::Effective::Post
  has_many_attached :attachments
end
class OverrideEffectivePosts
  #TODO: use autoloads.
end