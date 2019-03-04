module Okex
  module Wallet

    # 获取币种列表
    def currency_list
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/currencies"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 钱包账户信息
    def wallet_account_information
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/wallet"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 单一币种账户信息
    def single_currency_account_information(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/wallet/#{currency}"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 资金划转 限速规则：3次/s
    def transfer_of_funds(currency, amount, from, to, option={})
      timestamp = Time.now.utc.iso8601
      method = "POST"
      request_path = "/api/account/v3/transfer"
      body = {
        currency: currency,
        amount: amount,
        from: from,
        to: to,
        sub_account: option[:sub_account],
        instrument_id: option[:sub_account]
      }.to_json
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
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
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
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
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 查询最近所有币种的提币记录
    def query_the_currency_record_of_all_recent_currencies
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/withdrawal/history"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 查询单个币种提币记录
    def query_a_currency_record(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/withdrawal/history/#{currency}"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 账单流水查询
    def bill_flow_query(options={})
      timestamp = Time.now.utc.iso8601
      method = "GET"
      query_hash = {
        currency: options[:currency],
        type: options[:type],
        from: options[:from],
        to: options[:to],
        limit: options[:limit]
      }.compact

      query_params = query_hash.map{|k,v| "#{k}=#{v}" }.join("&")
      if query_params.present?
        request_path = "/api/account/v3/ledger?#{query_params}"
      else
        request_path = "/api/account/v3/ledger"
      end
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取充值地址
    def get_recharge_address(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/address?currency=#{currency}"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取所有币种充值记录
    def get_all_currency_recharge_records
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/history"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取单个币种充值记录
    def get_a_single_currency_recharge_record(currency)
      timestamp = Time.now.utc.iso8601
      method = "GET"
      request_path = "/api/account/v3/deposit/history/#{currency}"
      body = ""
      ok_access_sign = calculation_signature("#{timestamp}#{method}#{request_path}#{body}")
      final_hash = headers_hash(ok_access_sign, timestamp)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end
  end
end
