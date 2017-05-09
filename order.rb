class Order
  attr_accessor :id, :customer_email, :fulfilled, :products
  # product class which represents the internal json object array , which consists of an id, customer_email, fulfilled,
  # and array of products
  def initialize(id, customer_email, fulfilled, products)
    @id = id
    @customer_email = customer_email
    @fulfilled = fulfilled
    @products = products
  end

  # id setter
  def id=(id)
    @id = id
  end

  # id getter
  def getId
    return @id
  end

  # customer_email setter
  def customer_email=(customer_email)
    @customer_email = customer_email
  end

  # customer_email getter
  def getCustomer_email
    return @customer_email
  end

  # fulfilled stter
  def fulfilled=(fulfilled)
    @fulfilled = fulfilled
  end

  # fulfilled getter
  def isFulfilled
    return @fulfilled
  end

  # products setter
  def products=(products)
    @products = products
  end

  # products getter
  def getProducts
    return @products
  end

end