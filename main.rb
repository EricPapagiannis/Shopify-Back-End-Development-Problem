# imports
require 'net/http'
require 'json'

# import classes
require_relative 'product'
require_relative 'order'

# constants
$Nested_customer_email_id = 0
$Leading_json_url = 'https://backend-challenge-fall-2017.herokuapp.com/orders.json'
$Url_page_param = '?page='

# given a url that is a REST endpoint, retrieve the json object
def readJSONFromUrl(url)
  # use GET request to retrieve the json
  uri = URI(url)
  response = Net::HTTP.get(uri)
  json = JSON.parse(response)
  return json
end

# given a parsed json object for orders, build it into an Order class
def buildOrder(orderObject)
    return Order.new(orderObject['id'], orderObject['customer_email'], orderObject['fulfilled'], buildProducts(orderObject['products']))
end

# given a parsed json object for products, build it into array of  Products
def buildProducts(productObject)

  retArray = Array.new
  # iterate over every product json object and parse it into Product class, then add it to the returned array
  productObject.each do |obj|
    new_product = Product.new(obj['title'], obj['amount'])
    retArray.push(new_product)
  end
  return retArray
end

# given products, retrieve the first instance of a product that is a 'Cookie'
def getCookie(products)
  products.each do |product|
    if product.getTitle == 'Cookie'
      return product
    end
  end
end

# compares the list of orders to the ones that satisfy the challenge solution
def eligibleOrders(orders, available_cookies)
  eligibleorders = Array.new
  # iterate through each order, and if it is not fulfilled, then iterate over each product it has, then see if it is
  # an eligible order based on it it has less cookies than what is currently the available cookies
  orders.each do |order|
    if !order.isFulfilled
      order.getProducts.each do |product|
        if product.getTitle == 'Cookie' and product.getAmount <= available_cookies
          eligibleorders.push(order)
        end
      end
    end
  end
  return eligibleorders
end

# custom compare method that is used when sorting array of eligibleorders. accomplishes sorting the eligibleorders
# in descending cookie count and then if there is any repeats, it sorts the repeats so that the lowest id comes first
def compare(a, b)
  if getCookie(a.getProducts).getAmount - getCookie(b.getProducts).getAmount == 0
    return (b.getId - a.getId)
  else
    return (getCookie(a.getProducts).getAmount - getCookie(b.getProducts).getAmount)
  end
end

# run and solve the challenge
def solve
  # get the json object from the REST endpoint
  json = readJSONFromUrl($Leading_json_url)
  orders = json['orders']
  allorders = Array.new
  i = 1
  # iterate through the paginated api until there is no more valid orders, and build the allorders array
  while orders.size() != 0
    # get the json from the new page
    url = $Leading_json_url + $Url_page_param + i.to_s
    json = readJSONFromUrl(url)
    # get the orders and append them all into allorders array
    orders = json['orders']
    orders.each{|orderObject| allorders.push(buildOrder(orderObject)) }
    i+=1
  end

  # store temp values for output
  # store available cookies output
  retlineone = Hash.new
  # store unfulfilled_orders output
  retlinetwo = Hash.new

  available_cookies = json['available_cookies']
  retlineone['remaining_cookies'] = available_cookies

  unfulfilled_orders = Array.new
  # start building the unfulfilled_orders array by iterating over each order and see if the cookie count is higher than
  # the available cookies, if it is, then add it to unfulfilled_orders
  allorders.each do |order|
    if !order.isFulfilled
      order.getProducts.each do |product|
        if product.getTitle() == 'Cookie' and getCookie(order.getProducts).getAmount > available_cookies
          unfulfilled_orders.push(order.getId)
        end
      end
    end
  end
  retlinetwo['unfulfilled_orders'] = unfulfilled_orders
  # get all eligible orders to do challenge requirements on
  orderstocheck = eligibleOrders(allorders, available_cookies)

  # accomplishes sorting the eligibleorders ()using custom compare method)
  # in descending cookie count and then if there is any repeats, it sorts the repeats so that the lowest id comes first
  orderstocheck.sort!{|a, b| compare(a, b)}.reverse!
  # iterate through each order, and do cases for challenge. Since the list is 'doubly-sorted', a simple iteration down
  # from most to least cookies solves the challenge
  orderstocheck.each do |order|
    # if the cookies of the order is less than currently available cookies, decrement our available_cookies by how
    # much cookies the order has
    if getCookie(order.getProducts).getAmount <= available_cookies
      available_cookies -= getCookie(order.getProducts).getAmount
    else
      # otherwise the amount of cookies the order required was more than what was available, so it is unfulfilled, and
      # added to the array of unfulfilled_orders
      unfulfilled_orders.push(order.getId)
    end
  end
  # ensure that the final unfulfilled_orders array is sorted in ascending order
  unfulfilled_orders.sort!
  # create the hash that represents the output json object
  output_hash = {
      'remaining_cookies' => available_cookies,
      'unfulfilled_orders' => unfulfilled_orders
  }
  # get the output json object from the hash representation, in a properly formatted output
  output_json = JSON.pretty_generate(output_hash)
  # return the solved json
  return output_json
end


# solve the challenge
output_json = solve()
# display the json to console
puts output_json
# write local file with json string
File.open('solution.json','w') do |f|
  f.write(output_json)
end
