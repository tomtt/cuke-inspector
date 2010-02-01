# This generator adds files under public/cuke-inspector that are required to generate the table with step definitions
class CukeInspectorViewGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'public/cuke-inspector'
      m.directory 'public/cuke-inspector/images'
      m.directory 'public/cuke-inspector/javascripts'
      m.directory 'public/cuke-inspector/stylesheets'

      m.file 'public/cuke_inspector.html', 'public/cuke-inspector/index.html'

      m.file 'public/images/asc.gif',           'public/cuke-inspector/images/asc.gif'
      m.file 'public/images/bg.gif',            'public/cuke-inspector/images/bg.gif'
      m.file 'public/images/desc.gif',          'public/cuke-inspector/images/desc.gif'
      m.file 'public/images/toggle-closed.gif', 'public/cuke-inspector/images/toggle-closed.gif'
      m.file 'public/images/toggle-open.gif',   'public/cuke-inspector/images/toggle-open.gif'

      m.file 'public/javascripts/cucumber_step_completion.js',
             'public/cuke-inspector/javascripts/cucumber_step_completion.js'
      m.file 'public/javascripts/jquery-1.3.2.min.js',
             'public/cuke-inspector/javascripts/jquery-1.3.2.min.js'
      m.file 'public/javascripts/jquery.tablesorter-2.0.3.min.js',
             'public/cuke-inspector/javascripts/jquery.tablesorter-2.0.3.min.js'

      m.file 'public/stylesheets/tablesorter.css',
             'public/cuke-inspector/stylesheets/tablesorter.css'
      m.file 'public/stylesheets/cuke_inspector.css',
             'public/cuke-inspector/stylesheets/cuke_inspector.css'
    end
  end
end
