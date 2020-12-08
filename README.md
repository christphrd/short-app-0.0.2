# Algorithm
The algorithm used to the shorten the URL goes from its id number (base 10) to an alphanumeric short code (base 62) and vice versa.

A base is the system in which numbers are shown. If we are talking about base-n, the system has n characters.

To go from base 10 to base 62,
I like to think of it simply as writing out the digits for a number (going from base 10 to base 10). 
I have a number like 123,456. I convert it by taking the remainder using modulo with the base I want. Let's do base 10 for simplicity sake. I figure out what that corresponds to in my characters and have "6". I then divide my integer by the base I want and get 12,345.
The loop continues. I get "56". Then "456". Until "123456".
It's the same way with base 62. There's just extra characters because the base I want is 62.

To go from base 62 to base 10,
I like to think of it as binary (or base 2) to base 10.
I have a binary number like 101. You do (1 * 2 ** 2) + (0 * 2 ** 1) + (1 * 2 ** 0) = 5.
So you go through each digit multiply by the base raise to the power of its length - 1 and it decreases each time.

# Intial Setup

    docker-compose build
    docker-compose up mariadb
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
