# API ROUTES:

## Create user:

POST localhost:3000/api/v1/clients
Params: name, email, password, password_confirmation

## Sign in:

POST localhost:3000/api/v1/sessions
Params: email, password

## Sign out:

POST localhost:3000/api/v1/log_out
Params: authentication_token

## Fetch Menu:

POST localhost:3000/api/v1/menu
Params: authentication_token, restaurant_id

## Place Order:
POST localhost:3000/api/v1/orders
Params: :authentication_token, :restaurant_id, :table_id, :food_item_ids[], :food_item_quantities[]

## Set GCM:
POST localhost:3000/api/v1/set_gcm
Params: :authentication_token, :gcm

## Call Waiter:
POST localhost:3000/api/v1/waiter_call
Params: :authentication_token, :table_id