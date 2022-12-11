
# Advice
## Technology
* Ruby-3.1.2
* Bundler-2.3.17
* Rails-7.0.3
* Shopify API (2022-07)
* Postgres
* Redis
* Sidekiq
* Ngrok
* Shopify
* HTML, CSS, Liquid

## Development

### 1. Prerequisites

**Ngrok Setup**

- Install [Ngrok](https://ngrok.com/download)

- Create [Ngrok](https://dashboard.ngrok.com/signup) account and authenticate it

      $ ngrok authtoken <auth token>
      
- Start Ngrok tunnel on your local server listing port

      $ ngrok http -subdomain=your-tunnel-name 3000
      
**Shopify Store and App Setup**

- Create Shopify development store

- Create public app on shopify partner portal

- Go to app setup for configurations

  App URL: `https://your-tunnel-name.ngrok.io/`

  Allowed redirection URL(s):

      https://your-tunnel-name.ngrok.io/

      https://your-tunnel-name.ngrok.io/shopify

      https://your-tunnel-name.ngrok.io/auth/shopify/callback

  <img width="955" alt="image" src="https://user-images.githubusercontent.com/54504931/206916753-3b9465a8-833d-42d1-a710-e464150fc5c7.png">

  Subpath: `advice`

  Proxy URL: `https://your-tunnel-name.ngrok.io/`
  
  <img width="960" alt="image" src="https://user-images.githubusercontent.com/54504931/206917344-14794a26-ba9c-425b-a59f-d62f7f196bbf.png">

### 2. Initial Setup

- Clone the project repository

      $ git clone https://<TOKEN>@github.com/madeelshabbir/advice.git

- Get into the project directory

      $ cd advice

- Copy `.env.example` to `.env` and update required one

### 3. Start server

- Start sidekiq for background jobs

      $ sidekiq

- Open new terminal and start rails server

      $ rails s

### 4. Install App

- Now from app overview select your store to install it

  <img width="478" alt="image" src="https://user-images.githubusercontent.com/54504931/206917897-71a2f2b7-ac01-42ed-996d-bcd6c2a395e4.png">

- Explore your merchant side to verify app installation

  <img width="1439" alt="image" src="https://user-images.githubusercontent.com/54504931/206918384-f795d1c0-daa7-429e-9100-ba3ca3e77ce6.png">

- To explore the store front as well click on eye icon

  
