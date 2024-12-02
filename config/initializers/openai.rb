OpenAI.configure do |config|
    config.access_token = ENV.fetch("OPENAI_KEY")
    config.log_errors = Rails.env.production? ? false : true
end
# log_errors Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
