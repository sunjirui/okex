require "okex/version"
require 'okex/wallet'
require 'okex/delivery_contract'
require 'okex/perpetual_contract'

module Okex
  class Client
    include Okex::Wallet # 钱包API
    include Okex::DeliveryContract  # 交割合约API
    include Okex::PerpetualContract  # 永续合约API

    BaseUrl = 'https://www.okex.me'

    attr_accessor :ok_access_key, :ok_access_passphrase, :secret_key

    def initialize(options)
      raise "ok_access_key and ok_access_passphrase and secret_key is needed" if options.empty?
      @ok_access_key = options[:ok_access_key]
      @ok_access_passphrase = options[:ok_access_passphrase]
      @secret_key = options[:secret_key]
    end

    def headers_hash(ok_access_sign, time_stamp)
      {
        "OK-ACCESS-KEY" => ok_access_key,
        "OK-ACCESS-SIGN" => ok_access_sign,
        "OK-ACCESS-TIMESTAMP" => time_stamp,
        "OK-ACCESS-PASSPHRASE" => ok_access_passphrase,
        'Content-Type' => 'application/json'
      }
    end

    # 计算签名值
    def calculation_signature(wait_sign_string)
      sha256_string = OpenSSL::HMAC.digest('sha256', secret_key, wait_sign_string)
      Base64.encode64(sha256_string)
    end

    # 请求hash
    def request_hash(method, request_path, body)
      timestamp = Time.now.utc.iso8601
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      headers_hash(ok_access_sign, timestamp)
    end

    # 获取服务器时间
    def get_server_time
      request_url = "/api/account/v3/currencies"
      HTTParty.get("#{BaseUrl}#{request_url}", headers: {"OK-ACCESS-KEY" => ok_access_key})
    end
  end
end
