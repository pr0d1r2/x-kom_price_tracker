require_relative '../models/price'

module Xkom
  class Offer
    PRICE_XPATH = '//meta[@itemprop="price"]'.freeze

    def initialize(offer_id)
      @offer_id = offer_id
    end

    def price
      Price.find_or_create_by!(offer_id: @offer_id, date: Time.now.to_date, price: price_raw).price
    end

    private

    def price_raw
      @price_raw ||= offer_page.search(PRICE_XPATH).first[:content].to_i
    end

    def offer_page
      @offer_page ||= diskcache.cache("#{@offer_id}-#{Time.now.strftime('%Y-%M-%d')}") do
        agent.fetch(@offer_id)
      end
    end

    def diskcache
      @diskcache ||= Diskcached.new
    end

    def agent
      @agent ||= Agent.new
    end

    class Agent < Mechanize
      def fetch(offer_id)
        @offer ||= get("http://www.x-kom.pl/p/#{offer_id}.html")
      end
    end
  end
end
