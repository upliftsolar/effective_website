class EffectivePagesConstraint
  def self.matches?(request)
    Effective::Page.find(request.path_parameters[:id] || '/').present? rescue false
  end
end