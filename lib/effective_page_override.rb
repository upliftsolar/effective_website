require 'effective_pages'
Effective::Page.module_eval do
  scope :sorted, -> { order(:position) }
end

=begin

=end
