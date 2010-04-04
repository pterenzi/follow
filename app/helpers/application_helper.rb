# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def datepicker_tag(model, attribute, options ={}, datepicker_options = {})
    field_id = "#{model}_#{attribute}"
    field_name = "#{model}[#{attribute}]"
    field = ::ActionView::Helpers::InstanceTag.new(model, attribute, self)
    options = {:id => field_id, :name => field_name}.merge(options)
    datepicker_options = options_for_javascript(datepicker_options)
    js = "$(document).ready(function() { $(\"\##{field_id}\").datepicker(#{datepicker_options});});"
    field.tag(:input, options) + javascript_tag(js)
  end
end