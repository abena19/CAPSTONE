# CAPSTONE

- Dorm room wall
    - Social networking appfor college students
    - Bullentin board with all user feed
        - posts merged on wall(bullentin borard)
        - plan/status for the day
        - updates on academic ventures in the day(classes, assignments, meals)
        - social activity updates
        - picture posting capabilities
        - location update(based on user preference)
        

# DORM ROOM WALL

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app allows for a user to post and relate to other students within school by providing a social networking platform service for college students.

### App Evaluation
- **Category:** Social networking
- **Mobile:** Functionality would be limited to mobile devices
- **Story:** This app allows users to connect with other students through posts of daily life categories on a personalised 'wall'
- **Market:** Any individual within a college could choose to use this app
- **Habit:** This app could be used as often as the user want
- **Scope:** This app would initially be limited within specific schools but could be expanded to be a social network for all college students

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can login, register and sign out
* User can add and remove features to and from  dorm room wall (which would be initially organised) - customization to follow after MVP
* User can create and update preferences on different categories
* User can share walls, and location functionalities
* User can track location in real time
* Chat feature, history, compose, create
* User profiles
* User can view, follow and like walls

**Optional Nice-to-have Stories**

* Auto suggest other people who have signed up based on classes, halls, location, preferences
* Trending locations/ dorm room walls
* User can customise dorm room wall based on predetermined templates/ or toggle picture arrangements
* User can view a history of their walls
* Create statuses to disappear within 24 hours (initially a small button on profile on MVP)
* Archive chat, and walls
* User can tap on wall components for details

### 2. Screen Archetypes

* Login Screen
   * User can login
       * Google, FB, email
* Registration Screen
   * User can create a new account
   * Create preferences, interests

* Home page
    * User can view home feed, other walls
    * User can share with friends, like and follow other wall accounts

* Profile page
    * User can view profile page with username, followers (not based on counts), wall interaction level from other people

* My Wall page
    * User can upload posts components onto the wall
    * User can modify arrangement of wall components(stretch feature)
    * User can share wall to follwers

* Chat page
    * User can see a list of conversations and create new conversations with followers (to prevent random chats from others except in comments)

* Update page
    * User can update preferences, add categories, etc
    * User can view and change current status
    * User can notify group of change 

* Search page
    * User can search for other walls using filters
    
* Settings page
    * Change profile details
    * User can customise wall interface


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* My wall
* Chat

**Flow Navigation** (Screen to Screen)

* Login Screen
    => Home
* Registration Screen
    => Home
* Home Screen
    => Chat Screen
    => Profile Screen
* Profile Screen
    => Settings 
    => My wall screen
* My Wall Screen
    => Home (after posting)
    => Share screen
    => Customise screen
* User Wall Screen
    => Chat screen (of specific user)
    => Profile of user screen
    


## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://imgur.com/9olLrSD" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
 
