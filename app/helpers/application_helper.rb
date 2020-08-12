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

    if params.values.include?("static_pages") && params.values.include?("home")
      if @locale == 'es'
        nav_link_to 'English', url_for(locale: 'en')
      else
        nav_link_to 'Español', url_for(locale: 'es')
      end
    else # not /root
      fullpath = request.fullpath.dup.tap{|p| p.slice!(/^\/(en|es)/)}
      if @locale == 'es'
        nav_link_to 'English', File.join('/en',fullpath) #user_path(current_user, locale: 'en'), method: :put
      else
        nav_link_to 'Español', File.join('/es',fullpath) #user_path(current_user, locale: 'sp'), method: :put
      end
    end
  end


end
