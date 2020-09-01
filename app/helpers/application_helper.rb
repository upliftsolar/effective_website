module ApplicationHelper
  DYNAMIC_TRANSLATIONS = {}
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
        nav_link_to 'English', File.join(user_registration_path(locale: choice, confirm_locale: choice, redirect_to: change_url_for_locale(choice))), method: :patch
      else
        choice = 'es'
        nav_link_to 'Español', File.join(user_registration_path(locale: choice, confirm_locale: choice, redirect_to: change_url_for_locale(choice))), method: :patch
      end
    end
  end
  def change_url_for_locale(str)
   url_for(params.to_h.slice(:controller,:action,:id,:format).merge(locale: str))
  end
  def is_language?(str_or_sym)
    raise "@locale not set yet in request middleware. DEV ERROR" if @locale.nil?
    str_or_sym && str_or_sym.to_sym == @locale.to_sym
  end

  def t(str,*args)
    if params[:logout]
      #TODO: logout
    elsif current_user && current_user.email == "darius.roberts@gmail.com"
      locale = Tolk::Locale.where(name: "es").first_or_create!
      found = locale.phrases.includes(:translations).where(key: str.to_s).first_or_initialize
      if found && found.translations.any?
        #ok
      else
        found.save! rescue Rails.logger.error("Debugging. TOLK.")
        found.translations.where(text: str, locale: locale).first_or_create! rescue nil

        eo = Tolk::Locale.where(name: "eo").first_or_create!
        found.translations.where(text: str, locale: eo).first_or_create! rescue nil

        en = Tolk::Locale.where(name: "en").first_or_create!
        found.translations.where(text: str, locale: en).first_or_create! rescue nil
      end
    end

    if ENV["DYNAMIC_TRANSLATION"] && params[:debugging]
      locale = Tolk::Locale.where(name: @locale).first
      @memo_phrases ||= begin
        locale.phrases.includes(:translations)
      end
      trs8n = @memo_phrases.where(key: str.to_s).first.translations.for(locale)
      if trs8n
        #binding.pry if str.include?("navbar")
        return trs8n.text.html_safe
      end
    end
    super
  end

  def render_navbar_from_page_like_objs(env_str_navbar)
    blk = Proc.new
    navbar_effective_pages = Effective::Page.where('layout LIKE ?', "%navbar%").or(Effective::Page.where('layout LIKE ?', 'application')).where("draft"=>false)
    lookup_slug = navbar_effective_pages.select{|p| can?(:show, p) }.inject({}){|acc,p| acc.merge(p.slug =>p) }
    JSON.parse(env_str_navbar || "{}").each do |k,v| 
      if v.is_a?(Array)
        blk.call(k,v.map{|str| find_page_like(str,lookup_slug) })
      else
        blk.call(k,[find_page_like(v,lookup_slug)])
      end
    end
  end
  def find_page_like(str,lookup_slug)
    return str if str.starts_with?("/") 
    lookup_slug[str] || begin
    str.constantize
    rescue
      nil
    end
  end

  def render_nav_link(page)
    title,href = if page.is_a?(Effective::Page)
      [t(page.slug+"_page_title"), effective_pages.page_path(page)]
    elsif page == nil
      ["missing","/missing"]
    elsif page.is_a?(String) && page.starts_with?("/")
      token = page.dup.tap{|p| p.chomp!("/"); p.gsub!(/\W/,"_")}
      if @locale == "en"
        [t("#{token}_page_title"), "/en"+page]
      else
        [t("#{token}_page_title"), "/es"+page]
      end
    elsif page <= ServiceProvider
      [t('service_providers_page_title'), service_providers_path]
    elsif page <= Lead
      [t('create_lead_page_title'), new_lead_path]
    elsif page <= Question
      [t('create_questions_page_title'), questions_path]
    elsif page <= Community
      [t('communities_list_page_title'), list_communities_path]
    elsif page <= Effective::Post
      [t("blog_page_title"), effective_posts.posts_path]
    else
      [t(page.slug+"_page_title"), effective_pages.page_path(page)]
    end
    nav_link_to(title, href)
  end


end

class ActionController::Parameters
  def to_h
  @parameters.to_h
  end
end