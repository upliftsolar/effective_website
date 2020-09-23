require 'effective_posts'
class ::Effective::Post
  has_many_attached :attachments
  #TODO: figure out how to make fields show up on 'create'. _additional_fields is a little wonky.
  #validates :website_href, if: -> { ["news","papers"].include? category }, presence: true
end
class OverrideEffectivePosts
  #TODO: use autoloads.
end