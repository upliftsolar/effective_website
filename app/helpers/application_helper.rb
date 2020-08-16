module ApplicationHelper
  def user_tag(user, name: true)
    user ||= User.new

    avatar_tag = if user.avatar_attached? && user.avatar.attached? && (url = url_for(user.avatar) rescue false)
      content_tag(:span, class: 'user-avatar', title: user.to_s) { image_tag(url, alt: user.to_s) }
    end

    name_tag = content_tag(:span, user.to_s, class: 'user-name')

    [(avatar_tag if avatar_tag.present?), (name_tag if avatar_tag.blank? || name)].compact.join(' ').html_safe
  end
  def switch_language_option
    #TODO:
    #update user preferences

    if !current_user
      if is_language?('es')
        nav_link_to 'English', url_for(locale: 'en')
      else
        nav_link_to 'Español', url_for(locale: 'es')
      end
    else # not /root
      fullpath = request.fullpath.dup.tap{|p| p.slice!(/^\/(en|es)/)}
      if is_language?('es')
        choice = 'en'
        nav_link_to 'English', File.join(user_registration_path(locale: choice, confirm_locale: choice)), method: :patch
      else
        choice = 'es'
        nav_link_to 'Español', File.join(user_registration_path(locale: choice, confirm_locale: choice)), method: :patch
      end
    end
  end
  def is_language?(str_or_sym)
    raise "@locale not set yet in request middleware. DEV ERROR" if @locale.nil?
    str_or_sym && str_or_sym.to_sym == @locale.to_sym
  end


end
