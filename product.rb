class Product
  attr_accessor :title, :amount
  # product class which represents the internal json object array , which consists of a title and amount
  def initialize(title, amount)
    @title = title
    @amount = amount
  end

  # title setter
  def title=(title)
    @title = title
  end

  # title getter
  def getTitle
    return @title
  end

  # amount setter
  def amount=(amount)
    @amount = amount
  end

  # amount getter
  def getAmount
    return @amount
  end

end