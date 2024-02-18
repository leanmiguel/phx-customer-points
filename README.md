# Getting Going

mix setup
mix ecto.create
mix ecto.migrate
mix phx.server

single flow
create a new customer

```
curl --request POST \
  --url http://localhost:4000/api/customers/ \
  --header 'Content-Type: application/json' \
  --data '{
	"customer": {
			"phone_number": "4031234567"
	}
}'
```

manually change balance

```
curl --request POST \
  --url http://localhost:4000/api/customers/1/balances/manual_update \
  --header 'Content-Type: application/json' \
  --data '{
	"customer_balance": {
		"balance_change": 5000
	}
}'
```

get user balance

```
curl --request GET \
  --url http://localhost:4000/api/customers/1/balances
```

make an order

```
curl --request POST \
  --url http://localhost:4000/api/orders/ \
  --header 'Content-Type: application/json' \
  --data '{
	"order": {
		"currency": "JPY",
		"order_id": "d9675ba8-e352-422e-bb6d-9d230ae73fe8",
		"paid": 1000
	},
	"customer": {
		"phone_number": "4031234567"
	}
}'
```

get user balance and see updated points

```
curl --request GET \
  --url http://localhost:4000/api/customers/1/balances
```
