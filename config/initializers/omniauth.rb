Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify,
    ShopifyApp.configuration.api_key,
    ShopifyApp.configuration.secret,

    # Example permission scopes - see http://docs.shopify.com/api/tutorials/oauth for full listing
    scope: ShopifyApp.configuration.scope,

    setup: lambda {|env|
             params = Rack::Utils.parse_query(env['QUERY_STRING'])
             site_url = "https://#{params['shop']}"
             env['omniauth.strategy'].options[:client_options][:site] = site_url
             redirect_uri = "http://customappp.herokuapp.com/auth/shopify/callback
           }
end
