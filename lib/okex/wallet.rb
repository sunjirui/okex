module Okex
  module Wallet

    # 获取币种列表
    def currency_list
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/currencies"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 钱包账户信息
    def wallet_account_information
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/wallet"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 单一币种账户信息
    def single_currency_account_information(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/wallet/#{currency}"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 资金划转 限速规则：3次/s
    def transfer_of_funds(currency, amount, from, to, options={})
      timestamp = Time.now.utc.iso8601
      method = "POST"
      request_path = "/api/account/v3/transfer"
      body = {
        currency: currency,
        amount: amount,
        from: from,
        to: to,
        sub_account: options[:sub_account],
        instrument_id: options[:sub_account]
      }.to_json
      final_hash = request_hash(method, request_path, body)
      HTTParty.post("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash, body: body)
    end

    # 提币
    def extract_coins(currency, amount, destination, to_address, trade_pwd, fee)
      timestamp = Time.now.utc.iso8601
      method = "POST"
      request_path = "/api/account/v3/withdrawal"
      body = {
        currency: currency,
        amount: amount,
        destination: destination,
        to_address: to_address,
        trade_pwd: trade_pwd,
        fee: fee
      }.to_json
      final_hash = request_hash(method, request_path, body)
      HTTParty.post("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash, body: body)
    end

    # 提币手续费    暂时只能返回全部
    def extract_coin_fees(currency=nil)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      if currency.present?
        request_path = "/api/account/v3/withdrawal/fee?currency=#{currency}"
      else
        request_path = "/api/account/v3/withdrawal/fee"
      end
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 查询最近所有币种的提币记录
    def query_the_currency_record_of_all_recent_currencies
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/withdrawal/history"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 查询单个币种提币记录
    def query_a_currency_record(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/withdrawal/history/#{currency}"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 账单流水查询
    def bill_flow_query(options={})
      timestamp = Time.now.utc.iso8601
      method = "GET"
      query_params = options.compact.map{|k,v| "#{k}=#{v}" }.join("&")
      request_path = "/api/account/v3/ledger"
      request_path += "?#{query_params}" if query_params.present?
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取充值地址
    def get_recharge_address(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/address?currency=#{currency}"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取所有币种充值记录
    def get_all_currency_recharge_records
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/history"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取单个币种充值记录
    def get_a_single_currency_recharge_record(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/history/#{currency}"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end
  end
end
