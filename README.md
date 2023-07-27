Note: Site squirrel started as a service oriented Ruby on Rails application that allows users to create trips at National Parks and other federally managed lands and recieve notifications when hard to get campsite reservations become available. Recently it was announced that after several years without it, recreation.gov will soon implement this feature natively and that it is in beta testing for several campgrounds currently. New features, frontend work, additional CRUD functionality and deployment will be discontinued, but the application can still be forked / cloned and ran locally using local host and rails console/Postman for creating trips.


# README

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

`POST /api/v1/users`

    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
    "name" : "Bob Bobberson",
    "email": "whatever@example.com",
    "phone": "5555555555",
    "password_digest": "password",
    "password_confirmation": "password"
    }

### Response

<pre>
  {
    "data": {
        "id": "7",
        "type": "user",
        "attributes": {
            "name": "Bob Bobberson",
            "email": "whatever@example.com",
            "phone": "5555555555",
            "role": 0,
            "trips": {
                "data": []
            }
        }
    }
  }
</pre>

## Destroy a user

### Request

`DELETE /api/v1/users/7`

### Response

<pre>
{
    "message": "Record successfully destroyed"
}
</pre>

## Update a user

### Request

`PATCH /api/v1/users/6`

  PATCH /api/v1/users/6
  Content-Type: application/json
  Accept: application/json

### Response

<pre>
{
    "data": {
        "id": "6",
        "type": "user",
        "attributes": {
            "name": "Bob Bobberson",
            "email": "bobberson@example.com",
            "phone": "55555555555",
            "role": 0,
            "trips": {
                "data": []
            }
        }
    }
}
</pre>

## Create a trip (sets up notifications)

### Request

`POST /api/v1/users/6/trips`

    POST /api/v1/users/6/trips
    Content-Type: application/json
    Accept: application/json

            {
        "name": "My camping trip",
        "vehicle_length": "15",
        "tent_site_ok": true,
        "start_date": "2024-10-07",
        "number_nights": 2,
        "campground_id": "123456",
        "campground_location": "123213.23, 123232,12",
        "user_id": "6"
              }

### Response

<pre>
{
    "data": {
        "id": "12",
        "type": "trip",
        "attributes": {
            "name": "My camping trip",
            "campground_id": "123456",
            "vehicle_length": "15",
            "tent_site_ok": true,
            "campground_location": "123213.23, 123232,12",
            "start_date": "2024-10-07",
            "number_nights": 2
        }
    }
}
</pre>

## Get all of a user's trips

### Request

`GET /api/v1/users/6/trips`

### Response

<pre>
{
    "data": {
        "id": "6",
        "type": "user",
        "attributes": {
            "name": "Bob Bobberson",
            "email": "bobberson@example.com",
            "phone": "55555555555",
            "role": 0,
            "trips": {
                "data": [
                    {
                        "id": "12",
                        "type": "trip",
                        "attributes": {
                            "name": "My camping trip",
                            "campground_id": "123456",
                            "vehicle_length": "15",
                            "tent_site_ok": true,
                            "campground_location": "123213.23, 123232,12",
                            "start_date": "2024-10-07",
                            "number_nights": 2
                        }
                    },
                    {
                        "id": "13",
                        "type": "trip",
                        "attributes": {
                            "name": "My camping trip 2",
                            "campground_id": "123456",
                            "vehicle_length": "15",
                            "tent_site_ok": true,
                            "campground_location": "123213.23, 123232,12",
                            "start_date": "2024-10-07",
                            "number_nights": 2
                        }
                    }
                ]
            }
        }
    }
}

</pre>

## Create a session (no longer necessary as an API only application)

### Request

### Response








Matt Enyeart

Github: https://github.com/menyeart
LinkedIn https://www.linkedin.com/in/matt-enyeart/

