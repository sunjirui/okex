module Okex
  module PerpetualContract

    # 获取深度数据
    def get_depth_data(instrument_id, options={})
      method = "GET"
      query_params = options.map{|k,v| "#{k}=#{v}" }.join("&")
      request_path = "/api/swap/v3/instruments/#{instrument_id}/depth"
      request_path += "?#{query_params}" if query_params.present?
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取成交数据
    def get_transaction_data(instrument_id, options={})
      method = "GET"
      query_params = options.compact.map{|k,v| "#{k}=#{v}" }.join("&")
      request_path = "/api/swap/v3/instruments/#{instrument_id}/trades"
      request_path += "?#{query_params}" if query_params.present?
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取平台总持仓量
    def get_the_total_position_of_the_platform(instrument_id)
      method = "GET"
      request_path = "/api/swap/v3/instruments/#{instrument_id}/open_interest"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end

    # 获取当前限价 获取合约当前开仓的最高买价和最低卖价。
    def get_current_limit_price(instrument_id)
      method = "GET"
      request_path = "/api/swap/v3/instruments/#{instrument_id}/price_limit"
      body = ""
      final_hash = request_hash(method, request_path, body)
      HTTParty.get("#{Okex::Client::BaseUrl}#{request_path}", headers: final_hash)
    end
  end
end
