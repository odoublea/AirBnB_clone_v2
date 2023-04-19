# 0x02. AirBnB clone - MySQL

## To create an AirBnB clone using MySQL, you will need to design a database schema that can store all the necessary information about users, properties, bookings, and payments. Here's an example schema that can serve as a starting point:

1.User table:
user_id (PK)
username
email
password
phone_number

2.Property table:
property_id (PK)
owner_id (FK to user_id)
title
description
address
city
state
country
price_per_night
num_bedrooms
num_bathrooms
num_guests
image_url

3.Booking table:
booking_id (PK)
guest_id (FK to user_id)
property_id (FK to property_id)
checkin_date
checkout_date
num_guests
total_price

4.Payment table:
payment_id (PK)
booking_id (FK to booking_id)
payment_date
payment_method
amount_paid
With this schema, you can perform a variety of queries to retrieve information about users, properties, bookings, and payments. For example, you can retrieve all properties owned by a particular user, all bookings made by a particular user, all bookings for a particular property, and all payments for a particular booking.

Of course, this is just a basic schema, and you may need to customize it to fit your specific requirements. Additionally, you will need to create the necessary CRUD (Create, Read, Update, Delete) operations to interact with the database, as well as implement the necessary business logic to handle bookings, payments, and other aspects of your AirBnB clone.
