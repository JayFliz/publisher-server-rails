# To tell Puma when a request has timed out
# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#timeout

Rack::Timeout.timeout = 20 # seconds
