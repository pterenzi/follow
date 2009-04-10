require 'fileutils'

# Copy the table stylesheets (*.css) into RAILS_ROOT/public/stylesheets/table_css_styles
RAILS_ROOT = File.join(File.dirname(__FILE__), '../../../')

unless FileTest.exist? File.join(RAILS_ROOT, 'public', 'stylesheets', 'table_css_styles')
  FileUtils.mkdir( File.join(RAILS_ROOT, 'public', 'stylesheets', 'table_css_styles') )
end

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'stylesheets', '*.css')], 
  File.join(RAILS_ROOT, 'public', 'stylesheets', 'table_css_styles'),
  :verbose => true
)

# Copy controller, layout and views for table_css_styles demo
unless FileTest.exist? File.join(RAILS_ROOT, 'app', 'views', 'table_styles_demo')
  FileUtils.mkdir( File.join(RAILS_ROOT, 'app', 'views', 'table_styles_demo') )
end

FileUtils.cp( 
  File.join(File.dirname(__FILE__), 'controllers', 'table_styles_demo_controller.rb'), 
  File.join(RAILS_ROOT, 'app', 'controllers'),
  :verbose => true
)

FileUtils.cp( 
  File.join(File.dirname(__FILE__), 'views', 'layouts', 'table_styles_demo.rhtml'), 
  File.join(RAILS_ROOT, 'app', 'views', 'layouts'),
  :verbose => true
)

FileUtils.cp( 
  File.join(File.dirname(__FILE__), 'views', 'table_styles_demo', 'index.html.erb'), 
  File.join(RAILS_ROOT, 'app', 'views', 'table_styles_demo'),
  :verbose => true
)

# Show the README text file
puts IO.read(File.join(File.dirname(__FILE__), 'README'))


