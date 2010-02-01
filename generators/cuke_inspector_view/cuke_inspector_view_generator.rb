# This generator adds files under public/cuke-inspector that are required to generate the table with step definitions
class CukeInspectorViewGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'public/cuke-inspector'
      m.directory 'public/cuke-inspector/images'
      m.directory 'public/cuke-inspector/javascripts'
      m.directory 'public/cuke-inspector/stylesheets'

      m.file 'gitignore', 'public/cuke-inspector/.gitignore'
      m.file 'javascripts/gitignore', 'public/cuke-inspector/javascripts/.gitignore'

      m.file 'cuke_inspector.html', 'public/cuke-inspector/index.html'
      m.file 'cuke_inspector.html', 'public/cuke-inspector/index.html'

      m.file 'images/asc.gif',           'public/cuke-inspector/images/asc.gif'
      m.file 'images/bg.gif',            'public/cuke-inspector/images/bg.gif'
      m.file 'images/desc.gif',          'public/cuke-inspector/images/desc.gif'
      m.file 'images/toggle-closed.gif', 'public/cuke-inspector/images/toggle-closed.gif'
      m.file 'images/toggle-open.gif',   'public/cuke-inspector/images/toggle-open.gif'

      m.file 'javascripts/cucumber_step_completion.js',
             'cuke-inspector/javascripts/cucumber_step_completion.js'
      m.file 'javascripts/jquery-1.3.2.min.js',
             'cuke-inspector/javascripts/jquery-1.3.2.min.js'
      m.file 'javascripts/jquery.tablesorter-2.0.3.min.js',
             'cuke-inspector/javascripts/jquery.tablesorter-2.0.3.min.js'

      m.file 'stylesheets/tablesorter.css',
             'public/cuke-inspector/stylesheets/tablesorter.css'
      m.file 'stylesheets/cuke_inspector.css',
             'public/cuke-inspector/stylesheets/cuke_inspector.css'
    end
  end
end
