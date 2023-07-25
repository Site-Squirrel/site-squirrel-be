# README

Note: Site squirrel started as a service oriented Ruby on Rails application that allows users to create trips at National Parks and other federally managed lands and recieve notifications when hard to get campsite reservations become available. Recently it was announced that after several years without it, recreation.gov will soon implement this feature natively and that it is in beta testing for several campgrounds currently. All future work on Site Squirrel will go into making it a functioning open source API, but a frontend will most likely not be implemented and new features will be limited.


# Site Squirrel REST API

# Built With

  ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) 
  ![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
  ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

### Prerequisites

  - Ruby Version 3.1.1
  - Rails Version 7.0.6

## Install
    
    bundle install

## Create the database and run migrations
    
    rails db:create
    raild db:migrate

## Run the app

    rails s

## Run the tests

    bundle exec rspec

# API Endpoints

## Create a user

### Request

### Response

## Destroy a user

### Request

### Response

## Update a user

### Request

### Response

## Create a trip (sets up notifications)

### Request

### Response

## Destroy a trip

### Request

### Response

## Get all of a user's trips

### Request

### Response

## Create a session (no longer necessary as an API only application)

### Request

### Response








Matt Enyeart

Github: https://github.com/menyeart
LinkedIn https://www.linkedin.com/in/matt-enyeart/

