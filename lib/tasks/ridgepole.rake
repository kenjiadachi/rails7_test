namespace :ridgepole do
  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply')
  end

  desc 'Export database schema'
  task export: :environment do
    ridgepole('--export')
  end

  private

  def ridgepole(*options)
    command = ['bundle exec ridgepole -f db/Schemafile', '-c config/database.yml', "-E #{Rails.env}"]
    system((command + options).join(' '))
  end
end
