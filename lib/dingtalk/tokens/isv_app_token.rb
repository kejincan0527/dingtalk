require 'dingtalk/tokens/base'

module Dingtalk
  module Tokens
    class IsvAppToken < Base
      def key
        'access_token'
      end

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "#{self.class.name}_#{client.corpid}_#{client.app_id}"
      end

      def fetch_token
        # timestamp = (Time.now.to_f * 1000).to_i
        # sign_str = OpenSSL::HMAC.digest(
        #   OpenSSL::Digest.new('sha256'),
        #   client.suite_secret,
        #   "#{timestamp}\n#{client.suite_ticket}"
        # )
        # signature = ERB::Util.url_encode Base64.encode64(sign_str).strip
        client.request.post 'service/get_corp_token', {
          auth_corpid: client.corpid
        }, params: {
          suite_access_token: client.suite.access_token
        }
      end
    end
  end
end