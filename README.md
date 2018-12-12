# Software Engineering Final Project

Live application: https://sweships.herokuapp.com/


## About

A problem many Computer Science and Computer Engineering students encounter is the difficulty in finding internship opportunities that fit their skills; many of us do not know where to search for them, or do not know if we are suitable for the position.

To solve this problem, we created a web application that targets CSCI/CMPE students at UTRGV pursuing job opportunities in Software Engineering. The application works with an algorithm that matches internship postings with a student based on a their skills and qualifications. Our system allows for students to create an account, input their skills and qualifications, as well as their desired location to work in. Based on these inputs, the application returns listings that match from our database.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![Page Overview](https://github.com/ltephanysopez/se-final-project/blob/master/docs/sweships.gif)

## Features
The primary features of this application include the following:
- Authenticated user accounts
- Matching internships with premium users based on their skills
- Sorting internships based on user's preferred location
- Payment processing with Stripe



## Installation and Setup
If you would like to modify the code on your local machine, feel free to clone this repository and run it by doing the following:

```
git clone https://github.com/ltephanysopez/sweships.git
```

Navigate to the directory.
```
cd ~/Downloads/sweships
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

## Project Management

### Wireframing

![Index Overview](https://github.com/ltephanysopez/se-final-project/blob/master/docs/index.png)

![Listings Overview](https://github.com/ltephanysopez/se-final-project/blob/master/docs/listings.png)

### Databases
The application makes use of a two databases, described as follows:
- User database: Stores the data of free and signed up users. Free users may have empty fields such as “skills” and “preferred location” since they are not needed in their case. Premium users, on the other hand, should fill have fields complete in order to see internship listings.
- Listings database: Stores the data of every internship listing an administrator adds.

The local databases were implemented and tested using SQLite3 accessed via DataMapper. When deploying our application with Heroku, the database migrated to PostgreSQL.

![Database Overview](https://github.com/ltephanysopez/se-final-project/blob/master/docs/databases.png)


### User Flow and Interaction
![User Interaction Diagram Overview](https://github.com/ltephanysopez/se-final-project/blob/master/public/images/sweships_report.png)

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
