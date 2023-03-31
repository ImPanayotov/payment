## Used versions:
#### Ruby v.3.2.0
#### Rails v.7.0.4.2
#### PostgreSQL 15.2
#### Sidekiq 7.0.7
#### Redis server v.7.0.10 (at least v.6.2 needed to work with latest Sidekiq version)

## Setup
#### Clone the repo:
`git clone https://github.com/ImPanayotov/payment.git`
#### Install gems:
`bundle install`
#### Start server:
`rails s -p 3000` # or whichever port you like
#### Run Sidekiq:
`sidekiq`

## What's done by requirements:
#### 1. Using the latest version of most of the gems
#### 2. Using Slim templating engine with bootstrap (didn't focus on that)
#### 3. Covered most of the code with RSpecs, using FactoryBot, Shoulda Matchers, Rails Controller Testing - Services, Models, Policies, Controller, Request, Forms
#### 4. Comply with Most of the Rubocops' cops
#### 5. STI for transactions types
#### 7. Scopes for users with certain role, to list certain user roles
#### 8. Model validations for presence, length, inclusion etc.
#### 9. Custom validator for emails
#### 10. Factory pattern for transaction creation
#### 11. Meta-programming for defining user roles methods and for specs
#### 12. Extract devise options to module
#### 13. Use class method to return few chained scopes with arguments
#### 14. Private method used in form model
#### 15. Keeps controller as thin as possible using from object, factory and services
#### 16. For the admin part the views are using partials to separate the logic and to keep them thin and reusable
#### 17. Cron job created with Sidekiq scheduled to run every hour and destroy older than 1 hour transactions
#### Admin interface has an options to list all merchants, customer and transactions, to create/update/show/destroy customers and merchants.
#### Also on home page there's a link to sidekiq metric web page
#### I do have merchant and admin users, but I've created customers as well. Merchant could view all of their transactions, customer is also able to view their transactions. This is where my logic got a little messy and in conflict with polymorphic association. I didn't find the time to refactor it, but something like this should happen: transaction should become polymorphic with some name like :transactionable, so merchant and customer could depend on it. As I say - could be done with more time.
#### For the status changes I've planned to use state machine, but also couldn't get to it. With state machine is easier to change states and to restrict changing one state to another, e.g. :error to :approved.
#### Merchant can't be destroyed as long they have transactions. This is handled by restrict_with_error dependency.
#### Didn't write any integrations specs for now.
#### There's a few other things that would be great to have:
* Pagination for transactions/merchants/customers listings. I could achieve it with Kaminari.
* Match JSON response structure against expected structured which could be done with JSON matchers.
* Add API documentation using Swagger ot rswag.
#### There's a rake task that imports Admins and Merchants from CSV file:
`rake import:admins` or `rake import:merchants`

## Transactions are created only through API calls:
## You should create a merchant or use to login with already existing:

## Sign up path: /api/v1/signup
#### Sign up - please take in mind localhost address and port:
`curl --v --location 'localhost:3002/api/v1/signup' \
--header 'Content-Type: application/json' \
--data-raw '{
"merchant": {
"name": "API Merchant",
"email": "api.merchant@example.com",
"password": "Password123!",
"password_confirmation": "Password123!",
"description": "description"
}
}'`
#### You should use the Authorization header for further request.

## Sign in path: /api/v1/login
#### You could also Sign in if already have created merchant:
`curl -v --location 'localhost:3002/api/v1/login' \
--header 'Content-Type: application/json' \
--data-raw '{
"merchant": {
"email": "api.merchant@example.com",
"password": "Password123!"
}
}'`
#### Again - take the Authorization token for further requests. Or maybe use cookies with postman?

## Auhtorize transaction path: /api/v1/transactions/authorize_transaction
#### To create AUTHORIZE TRANSACTION replace the authorization token with your own. The customers from the seed file are by default with 1_000_000 cents:
`curl --location 'localhost:3002/api/v1/transactions/authorize_transaction' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyMzdlOGNlNi0wMWY2LTQ4NDctOWFiZi0wNjZhMmE2OWE5NGEiLCJzdWIiOiIyMSIsInNjcCI6Im1lcmNoYW50IiwiYXVkIjpudWxsLCJpYXQiOjE2ODAyNjc2NTEsImV4cCI6MTY4MDI3NDg1MX0.LLHUtUyE_1-a2i8Bcu2R6ZPDd-PTSOwcBIGIfQXNPZQ' \
--header 'Content-Type: application/json' \
--data '{
"transaction": {
"amount_cents": 200000,
"customer_id": 1,
"details": "No details",
"type": "AuthorizeTransaction"
}
}'`

## Refund transaction path: /api/v1/transactions/:charge_transaction_id/refund_transaction
#### To create REFUND TRANSACTION take the approved Charge transaction UUID from console or admin interface:
`curl --location 'localhost:3002/api/v1/transactions/96e74d3f-d171-4304-be8e-9d8791cdc225/refund_transaction' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIyMzdlOGNlNi0wMWY2LTQ4NDctOWFiZi0wNjZhMmE2OWE5NGEiLCJzdWIiOiIyMSIsInNjcCI6Im1lcmNoYW50IiwiYXVkIjpudWxsLCJpYXQiOjE2ODAyNjc2NTEsImV4cCI6MTY4MDI3NDg1MX0.LLHUtUyE_1-a2i8Bcu2R6ZPDd-PTSOwcBIGIfQXNPZQ' \
--header 'Content-Type: application/json' \
--data '{
"transaction": {
"amount_cents": 200000,
"customer_id": 4,
"details": "No details",
"type": "RefundTransaction"
}
}'`

## Sign out path: DELETE /api/v1/logout
#### You can sign out using the authorization token
`curl --location --request DELETE 'localhost:3002/api/v1/logout' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxY2U5NmMyZC03ZmRjLTQ1ODYtYTVlMS01ZjkxYTQ0N2FjNjMiLCJzdWIiOiIyMiIsInNjcCI6Im1lcmNoYW50IiwiYXVkIjpudWxsLCJpYXQiOjE2ODAyNzIwODMsImV4cCI6MTY4MDI3OTI4M30.6blVhaG0wK-mgkldkfmeT6H0VUBw1u8lR93L3hFF7tA' \
--data ''`
