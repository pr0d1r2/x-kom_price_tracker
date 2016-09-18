class PriceWoTaxes
  VAT = 23 # %
  PIT = 19 # %

  def initialize(price)
    @price = price
  end

  def self.vat(price)
    new(price).vat
  end

  def self.all(price)
    new(price).all
  end

  def vat
    @price / (1 + VAT * 0.01)
  end

  def all
    vat / (1 + PIT * 0.01)
  end
end
