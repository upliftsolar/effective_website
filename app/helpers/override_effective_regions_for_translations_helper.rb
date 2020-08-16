require 'effective_regions_helper'
EffectiveRegionsHelper.module_eval do
  old_effective_region = instance_method(:effective_region)

  define_method(:effective_region) do |*args|
    r = old_effective_region.bind(self).(*args).dup
    if @locale 
      lang_tags = r.scan(/(([A-Z]{2}):\[\[(.*?)\]\])/m)
      for lang_tag in lang_tags
        if lang_tag[1].to_s == @locale.to_s.upcase
          r.gsub!(lang_tag[0],lang_tag[2])
        else
          r.gsub!(lang_tag[0],"")
        end
      end
    end
    r.html_safe
  end 
end

OverrideEffectiveRegionsForTranslationsHelper =  EffectiveRegionsHelper