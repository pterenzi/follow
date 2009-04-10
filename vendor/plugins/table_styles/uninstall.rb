require 'fileutils'

RAILS_ROOT = File.join(File.dirname(__FILE__), '../../../')

FileUtils.rm_rf(File.join(RAILS_ROOT, 'public', 'stylesheets', 'table_css_styles'),
  :verbose => true
)

FileUtils.rm_rf(File.join(RAILS_ROOT, 'app', 'views', 'table_styles_demo'),
  :verbose => true
)

FileUtils.rm_f(File.join(RAILS_ROOT, 'app', 'controllers', 'table_styles_demo_controller.rb'),
  :verbose => true
)

FileUtils.rm_f(File.join(RAILS_ROOT, 'app', 'views', 'layouts', 'table_styles_demo.rhtml'),
  :verbose => true
)

p '========== Uninstallation is completed =========='
