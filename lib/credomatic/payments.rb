require "credomatic/payments/version"
require 'digest'
require "net/http"
require "uri"
require "json"
require 'cgi'

module Credomatic
  module Payments
    class Transactions

      def initialize(key_id, key)
        @key_id = key_id
        @key = key
        @redirect_url = "https://credomatic.compassmerchantsolutions.com/api/transact.php"
        @api_url = "https://credomatic.compassmerchantsolutions.com/api/transact.php"
      end

      def input_hash(orderid, amount, time)
        value =  "#{orderid}|#{'%.2f' % amount}|#{time}|#{@key}"
        Digest::MD5.hexdigest(value)
      end

      def response_hash(orderid, amount, response, transactionid, avsresponse, cvvresponse, time)
        value =  "#{orderid}|#{'%.2f' % amount}|#{response}|#{transactionid}|#{avsresponse}|#{cvvresponse}|#{time}|#{@key}"
        Digest::MD5.hexdigest(value)
      end


      def generate_transaction(type, redirect_url, ccnumber, ccexp, amount, orderid, cvv, avs, processor_id)
        @time = Time.now.getutc.to_i
        if type == "sale"
          @input_hash = input_hash("", amount, @time)
        else
          @input_hash = input_hash(orderid, amount, @time)
        end
        
        if redirect_url == nil
          uri = URI(@api_url)
          params = {
            type: type,
            key_id: @key_id,
            hash: @input_hash,
            time: @time,
            ccnumber: ccnumber,
            ccexp: ccexp,
            amount: "#{'%.2f' % amount}",
            orderid: orderid,
            cvv: cvv,
            avs: avs,
            processor_id: processor_id
          }
          response = Net::HTTP.post_form( uri, params )

          if( response.is_a?( Net::HTTPSuccess ) )
            # your request was successful
            responseValue = CGI::parse(response.body)
            responseValue = responseValue.each { |key, value| responseValue[key] = value.first}
            responseValue
          else
            # your request failed
            responseValue = CGI::parse(response.body)
            responseValue = responseValue.each { |key, value| responseValue[key] = value.first}
            responseValue
          end
        end

      end
      
      def key_id
        @key_id
      end

    end 
  end
end
