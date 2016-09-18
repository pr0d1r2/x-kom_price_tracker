require_relative '../price_wo_taxes'
require_relative 'offer'

module Xkom
  class Disk
    ARRAY_SIZE = 12
    RAIDZ_LEVEL = 3

    delegate :price, to: :offer

    def initialize(size_in_gb, offer_id)
      @size_in_gb = size_in_gb
      @offer_id = offer_id
    end

    def price_info
      puts
      puts @offer_id
      puts
      puts "size_in_gb: #{@size_in_gb}"
      puts
      puts "price: #{price}"
      puts "price_per_gb: #{price_per_gb}"
      puts
      puts "min_price: #{min_price}"
      puts "max_price: #{min_price}"
      puts
      puts "min_price_per_gb: #{min_price_per_gb}"
      puts "max_price_per_gb: #{max_price_per_gb}"
      puts
      puts
      puts "array_space_in_gb: #{array_space_in_gb}"
      puts
      puts "price_for_array: #{price_for_array}"
      puts "price_for_array_wo_vat: #{price_for_array_wo_vat}"
      puts "price_for_array_wo_taxes: #{price_for_array_wo_taxes}"
    end

    private

    def array_space_in_gb
      (ARRAY_SIZE - RAIDZ_LEVEL) * @size_in_gb
    end

    def price_for_array_wo_taxes
      PriceWoTaxes.all(price_for_array).round(2)
    end

    def price_for_array_wo_vat
      PriceWoTaxes.vat(price_for_array).round(2)
    end

    def price_for_array
      ARRAY_SIZE * price
    end

    def min_price_per_gb
      (min_price.to_f / @size_in_gb.to_f).round(4)
    end

    def max_price_per_gb
      (max_price.to_f / @size_in_gb.to_f).round(4)
    end

    def min_price
      @min_price ||= Price.where(offer_id: @offer_id).minimum(:price)
    end

    def max_price
      @max_price ||= Price.where(offer_id: @offer_id).maximum(:price)
    end

    def price_per_gb
      (price.to_f / @size_in_gb.to_f).round(4)
    end

    def offer
      @offer || Offer.new(@offer_id)
    end
  end
end
