# Sweships

![Application Overview](https://github.com/ltephanysopez/sweships/blob/master/docs/home-page.png)


## About

Sweships is a web application designed for CS/CE students pursuing job opportunities in Software Engineering. The application works with an algorithm that matches internship postings with a student based on their skills and qualifications. Our service allows users to create a profile, customize their account with skills and programming languages they're most experienced with, and view internships in our database that are most relevant to their profile. Additionally, we've added a collection of resources that we think will be helpful to students interested in networking, expanding their skillset, or scholarships.


## Features
The primary features of this application include the following:
- Authenticated user accounts
- Matching internships with premium users based on their skills
- Sorting internships based on user's preferred location
- Payment processing with Stripe


## Installation and Setup
If you would like to modify the code on your local machine, feel free to clone this repository and run it by doing the following:

```
git clone https://github.com/ltephanysopez/swe-ships.git
```

Navigate to the directory.
```
cd ~/Downloads/swe-ships
```

Install all necessary gems
```
bundle install
```

Run the server
```
bundle exec ruby app.rb
```

By default the server runs on port 4567, so to view the application on your local machine, head to http://localhost:4567/



## Wireframing
Below are the original sketches for the web application.

![Index Overview](https://github.com/ltephanysopez/sweships/blob/master/docs/index.png)

![Listings Overview](https://github.com/ltephanysopez/sweships/blob/master/docs/listings.png)



### Databases
The application makes use of a two databases, described as follows:
- User database: Stores the data of free and signed up users. Free users may have empty fields such as “skills” and “preferred location” since they are not needed in their case. Premium users, on the other hand, should fill have fields complete in order to see internship listings.
- Listings database: Stores the data of every internship listing an administrator adds.
- Scholarships database: Stores the data of every scholarships listing an administrator adds.
- Conferences database: Stores the data of every conference listing an administrator adds.

The local databases were implemented and tested using SQLite3 accessed via DataMapper. When deploying our application with Heroku, the database migrated to PostgreSQL.


## Tech Stack
To build the application, we used:
- Ruby
- HTML
- CSS
- BootStrap
- JavaScript
- jQuery
- Heroku
- Stripe API
- PostgreSQL
- DataMapper
- Google Fonts


Additionally, Slack, Git, and Github were used to discuss the project timeline and progress.


## Authors
- [Stephany Lopez](https://www.ltephanysopez.com)
- [Cecy Sanchez](https://acsanchezr.github.io/)
- Tarana Mou


## Acknowledgement

A special thank you to Eric Martinez, who assisted us throughout the project.
