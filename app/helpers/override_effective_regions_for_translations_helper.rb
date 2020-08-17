require 'effective_regions_helper'
EffectiveRegionsHelper.module_eval do

  old_ckeditor_region = instance_method(:ckeditor_region)

  define_method(:ckeditor_region) do |args,options={},&block|
    r = old_ckeditor_region.bind(self).(args,options,&block).dup
    if effectively_editing?
      #ok
    elsif r
      handle_translation(r)
    end
    r.html_safe
  end 
  def handle_translation(r)
    lang_tags = r.scan(/(([A-Z]{2}):\[\[(.*?)\]\])/m)
    for lang_tag in lang_tags
      if lang_tag[1].to_s == @locale.to_s.upcase
        r.gsub!(lang_tag[0],lang_tag[2])
      else
        r.gsub!(lang_tag[0],"")
      end
    end
    r
  end
end

OverrideEffectiveRegionsForTranslationsHelper =  EffectiveRegionsHelper