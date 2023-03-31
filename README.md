## Used versions:
#### Ruby v.3.2.0
#### Rails v.7.0.4.2
#### PostgreSQL 15.2
#### Sidekiq 7.0.7
#### Redis server v.7.0.10 (at least v.6.2 needed to work with latest Sidekiq version)

## What's done from the requirements:
#### 1. Using the latest version of most of the gems
#### 2. Using Slim templating engine with bootstrap (didn't focus on that)
#### 3. I've covered most of the code with RSpecs, using FactoryBot, Shoulda Matchers, Rails Controller Testing - Services, Models, Policies, Controller, Request, Forms
#### 4. 

## Setup
#### Clone the repo:
`git clone https://github.com/ImPanayotov/payment.git`
#### Install gems:
`bundle install`
#### Start server:
`rails s -p 3000` # or whichever port you like
#### Run Sidekiq:
`sidekiq`
