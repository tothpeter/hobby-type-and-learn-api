namespace :puma do
  %w[start stop restart prestart].each do |command|
    desc "#{command} Puma server."
    task command do
      on roles(:app) do
        execute "/etc/init.d/puma_api #{command}"
      end
    end
  end
end