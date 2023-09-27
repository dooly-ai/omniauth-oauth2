require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Hubspot < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "hubspot"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "https://app.hubspot.com/oauth/authorize?client_id=6e04b174-22cc-4be5-929c-49a56d6a2f34&redirect_uri=https://api.local.dooly.ai/api/v1/hubspot_authentication&scope=crm.lists.read"}

      # You may specify that your strategy should use PKCE by setting
      # the pkce option to true: https://tools.ietf.org/html/rfc7636
      option :pkce, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end
