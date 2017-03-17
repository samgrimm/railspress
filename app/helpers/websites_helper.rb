module WebsitesHelper

  def stylesheet(website)
    if website.color_combo.present?
      website.color_combo.name.downcase
    else
      'application'
    end
  end

  def page_link_exists?(navbar, page)
    !navbar.pages.where(id: page.id).empty?
  end

  def current_link(navbar, page)
    link = Link.where(page_id: page.id, navbar_id: navbar.id).first
  end

  def website_footer?(website)
    !website.navbars.where(position: 'footer').empty?
  end

  def website_main_nav?(website)
    !website.navbars.where(position: 'main').empty?
  end

  def navbar_style(navbar)
    if navbar.nav_style.present?
      return navbar.nav_style.name
    end
  end

  def main_nav(website)
    nav_items = website.navbars.where(position: 'main').first.pages
    nav_links = ''
    nav_items.each do |item|
      item_url = website_page_path(website, item, locale:I18n.locale)
      nav_links << "<li><a href='#{item_url}' class='nav-link #{active? item_url}' >#{item.title}</a></li>"
    end
    nav_links.html_safe

  end

  def footer_nav(website)
    footer_items = website.footer.pages
    footer_links = ''
    if footer_items.empty?
      footer_links << "Add Pages to the Footer"
    else
      footer_items.each do |item|
        item_url = website_page_path(website, item, locale:I18n.locale)
        footer_links << "<li><a href='#{item_url}' class='nav-link #{active? item_url}' >#{item.title}</a></li>"
      end
    end
    footer_links.html_safe

  end
end
