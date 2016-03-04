Devise.setup do |config|
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  # Devise will use the `secret_key_base` on Rails 4+ applications as its `secret_key`
  # by default. You can change it below and use your own secret key.
  # config.secret_key = 'b6b7a518f3cd887d3d9d43e71a2af57388f1ce49e8156c1b5cd333d296baf2d91a85e51760e5b633f12bb2e2a95144cba7bbc7f0bf2beef59d4939d2465f20bd'

  config.mailer_sender = 'message_wall@example.com'

  # Configure the class responsible to send e-mails.
  # config.mailer = 'Devise::Mailer'

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]


  # By default Devise will store the user in session. You can skip storage for
  # particular strategies by setting this option.
  # Notice that if you are skipping storage for all authentication paths, you
  # may want to disable generating routes to Devise's sessions controller by
  # passing skip: :sessions to `devise_for` in your config/routes.rb
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  config.omniauth :twitter,
                  ENV['TWITTER_API_KEY'],
                  ENV['TWITTER_API_SECRET']
  
  config.omniauth :google_oauth2,
                  ENV['GOOGLE_CLIENT_ID'],
                  ENV['GOOGLE_CLIENT_SECRET'],
                  {
                    name: 'google',
                    prompt: 'select_account',
                    image_aspect_ratio: 'square',
                    image_size: 50
                  }

  config.omniauth :facebook,
                  ENV['FACEBOOK_APP_ID'],
                  ENV['FACEBOOK_APP_SECRET'],
                  { image_size: 'square' }

  config.omniauth :vkontakte,
                  ENV['VK_APP_ID'],
                  ENV['VK_APP_SECRET'],
                  { image_size: 'mini' }

  # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  # so you need to do it manually. For the users scope, it would be:
  # config.omniauth_path_prefix = '/my_engine/users/auth'
end
