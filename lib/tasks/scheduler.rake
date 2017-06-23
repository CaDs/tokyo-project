# frozen_string_literal: true

desc 'This task is called by the Heroku scheduler add-on'
task cache_pictures: :environment do
  puts 'Caching pictures...'
  Picture.preload_all_pictures
  puts 'done.'
end
