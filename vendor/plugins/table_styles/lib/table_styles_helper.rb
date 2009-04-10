# TableStylesHelper

module TableStylesHelper

  def table_stylesheet_link_tag table_style
    stylesheet_link_tag "table_css_styles/#{table_style}"
  end
  
end
