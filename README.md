# Shopify-Back-End-Development-Problem
My solution to the Shopify Back End Development Problem

The resulting JSON:
{

  "remaining_cookies": 0,
  
  "unfulfilled_orders": [
  
    7,
    
    8,
    
    11
    
  ]
  
}

(The following text was pulled from the Shopify's google doc containing the challenge):

Back End Development Problem

One Shopify merchant bakes tasty treats and sells them locally, but they haven’t been able to bake cookies fast enough to keep up with the demand of all the orders. Because of this, they have asked for your help to organize all cookie orders, so they can see which orders they will need to bake more cookies for.

You have a limited amount of cookies remaining and a list of orders. The merchant needs to know which orders will not be *fulfilled after following the requirements specified below.

*order fulfillment: The process between when a merchant receives an order from a customer and delivers the product into the customer's hands.

You have access to a paginated API in: https://backend-challenge-fall-2017.herokuapp.com/orders.json where you can obtain all the orders. The API accepts a page parameter, example: https://backend-challenge-fall-2017.herokuapp.com/orders.json?page=2

Requirements

Read all orders from the paginated API. Any order without cookies can be fulfilled. Prioritize fulfilling orders with the highest amount of cookies. If orders have the same amount of cookies, prioritize the order with the lowest ID. If an order has an amount of cookies bigger than the remaining cookies, skip the order.

What to submit:

Output (in JSON)

{

  "remaining_cookies": "Amount of cookies remaining after trying to fulfill orders",
  
  "unfulfilled_orders": [ "IDs of the order that couldn't be fulfilled in ascending order" ]
  
}

*Example Answer Output

{

  "remaining_cookies": 0,
  
  "unfulfilled_orders": [ 3, 5 ]
  
}
