module ActionView::Helpers::FormOptionsHelper
  
  # Return select and option tags for the given object and method, using table_style_options_for_select to generate the list of option tags.
  def table_style_select(object, method, options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, nil, options.delete(:object)).to_table_style_select_tag(options, html_options)
  end
  
  # Returns a string of option tags for table styles
  # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
  def table_style_options_for_select(selected = nil)
    options_for_select(TABLE_STYLES, selected)
  end
  
  private
  
  TABLE_STYLES=["10_minutes", "aqua", "blaugrana", "blu_in_block", "bluish", "candy", "casablanca", "chives_tables", "clean_and_crisp", "clear_blue", "coffee_with_milk", "dark_night", "foggy_country", "golden_style", "grayed_out", "grey_scale", "icubed", "infected", "jacob", "like_adwords", "media_groove", "minimalist", "mint_green", "muted", "orange_and_grey", "orange_brownie", "oranges_in_the_sky", "plain_old_table", "pop_pop_star", "pretty_in_pink", "red_and_black", "salmon", "sea_glass", "shades_of_blue", "shades_of_purple", "simple_and_clean", "smooth_taste", "stainless_steel", "tabular_tables", "tagbox", "the_oc", "warm_fall"] unless const_defined?("TABLE_STYLES")
  
end

class ActionView::Helpers::InstanceTag
  
  def to_table_style_select_tag(options, html_options)
    html_options = html_options.stringify_keys
    add_default_name_and_id(html_options)
    value = value(object)
    selected_value = options.has_key?(:selected) ? options[:selected] : value
    content_tag("select", add_options(table_style_options_for_select(selected_value), options, value), html_options)
  end
end


class ActionView::Helpers::FormBuilder
  def table_style_select(method, options = {}, html_options = {})
    @template.table_style_select(@object_name, method, options.merge(:object => @object), html_options)
  end
end 
