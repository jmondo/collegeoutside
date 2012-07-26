configatron.default_host = {
  :development => "localhost:3000",
  :test => "localhost:3000",
  :production => "appname.com",
  :staging => "staging.appname.com"
}[Rails.env.to_sym]

ActionMailer::Base.default_url_options[:host] = configatron.default_host
