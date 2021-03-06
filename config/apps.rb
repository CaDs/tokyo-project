# frozen_string_literal: true

##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  enable :sessions
  set :session_secret, 'd54edc81abd3eff6197e4db5f3507e4cd36bbdc39c588b3dca8802ebfd3c9cbd'
  set :protection, except: :path_traversal
  set :protect_from_csrf, true
end
Padrino::Logger::Config[:development] = { log_level: :debug, stream: :to_file }


# Mounts the core application for this project

Padrino.mount('TokyoProject::Admin', app_file: Padrino.root('admin/app.rb')).to('/admin')

Padrino.mount('TokyoProject::Admin', app_file: Padrino.root('admin/app.rb')).to('/admin')
Padrino.mount('TokyoProject::App', app_file: Padrino.root('app/app.rb')).to('/')
