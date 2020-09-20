class StaticPagesController < ApplicationController
  skip_authorization_check # CanCanCan

  def home
    @page_title = "#{ENV['WEBSITE_HUMAN_NAME'] || 'Example Website'}"
  end
  def sitemaps
    #built and checked in by rails sitemap:refresh 
  end
  def robots
    template = ERB.new Rails.root.join("app/views/static_pages/robots.html.erb").read, nil, "%"
    txt = template.result(binding)
    render plain: txt
    return false
  end

  def nav_link_to(*args); nil end

  def createsitemaps
    SitemapGenerator::Sitemap.default_host = ENV['BASE_URL']

    $navbar_links = {}
    render_navbar_from_page_like_objs(ENV['NAVBAR']) do |k,list|
      #eng_title,list|
      for pagelike in list
        next if not pagelike
        opts = {:changefreq => 'yearly'} 
        opts[:lastmod] = pagelike.respond_to?(:updated_at) ? pagelike.updated_at : (Time.now - 1.day)
        render_nav_link(pagelike) do |href|
          if pagelike.respond_to?(:slug)
            $navbar_links[pagelike.slug] = opts.dup
          else
            $navbar_links[href] = opts.dup
          end
        end
      end
    end 

    SitemapGenerator::Sitemap.create do
      {en: :english, es: :spanish}.each_pair do |locale, name|
        group(:sitemaps_path => "sitemaps/#{locale}/", :filename => name) do
          add root_path(locale: locale), :changefreq => 'yearly'

          for href,opts in $navbar_links
            add "/#{locale}/#{href}", opts 
          end
      
          %w{events papers}.each do |category|
            posts = ::Effective::Post.where(category: category).order(:created_at)
            add "/#{locale}/blog/category/#{category}", :changefreq => 'daily', :lastmod => posts.last&.updated_at
      
            posts.each do |post|
              add "/#{locale}/#{post.slug}", :changefreq => 'yearly', :lastmod => post.created_at
            end
          end

=begin
          extend EffectivePostsHelper
          %w{news papers}.each do |category|
            posts = ::Effective::Post.where(category: category).order(:created_at)
            add effective_post_category_path(category, locale: locale), :changefreq => 'daily', :lastmod => posts.last.updated_at
      
            posts.each do |post|
              add effective_post_path(post, locale: locale), :changefreq => 'yearly', :lastmod => post.created_at
            end
          end
=end

        end
      end

      # Put links creation logic here.
      #
      # The root path '/' and sitemap index file are added automatically for you.
      # Links are added to the Sitemap in the order they are specified.
      #
      # Usage: add(path, options={})
      #        (default options are used if you don't specify)
      #
      # Defaults: :priority => 0.5, :changefreq => 'weekly',
      #           :lastmod => Time.now, :host => default_host
      #
      # Examples:
      #
      # Add '/articles'
      #
      #   add articles_path, :priority => 0.7, :changefreq => 'daily'
      #
      # Add all articles:
      #
      #   Article.find_each do |article|
      #     add article_path(article), :lastmod => article.updated_at
      #   end

    end

    render plain: "OK"
    return false
  end

end
