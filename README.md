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

[X] User can login, register and sign out
[X] User can add images to dorm room wall
[X] User can view location functionalities(current location, other location displayed on wall)
[X] User can track location in real time
[X] User profiles
[X] User can view and like walls
[X] User can view walls in airplane mode, or without connection


**Optional Nice-to-have Stories**

* Auto suggest other people who have signed up based on classes, halls, location, preferences
* Trending locations/ dorm room walls
* User can customise dorm room wall based on predetermined templates/ or toggle picture arrangements
* User can view a history of their walls
* Create statuses to disappear within 24 hours
* User can tap on wall components for details

### 2. Screen Archetypes

* Login Screen
   * User can login
       * FB, email
* Registration Screen
   * User can create a new account
   * Create preferences, interests

* Home page
    * User can view home feed, other walls
    * User can view, like or follow other wall accounts

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
    
* Settings page
    * Change profile details
    * User can customise wall interface


### 3. Navigation 

**Tab Navigation** (Tab to Screen)

[X] Home Feed
[X] My wall
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
<img src="https://imgur.com/9olLrSD.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models
[X] Wall
[X] User (from parse)
[X] Expiring Wall
* Like

### Networking
- Parse Network Requests
* Home feed Screen
    - (Read/GET)Query all walls that the user follows
    - (Create/WALL) Create new like on wall 
    - (Create/WALL) Create new comment on wall 
    - (Delete) Remove existing like or comment

* My Wall Screen
    - (Create/WALL) Create new wall 
    - (Update/WALL) Edit wall
    - (Delete/WALL) Remove existing wall
    
* Profile Screen
    - (Read/GET)Query logged in user object
    - (Update/PUT) Update user profile image
    


- [Create basic snippets for each Parse network request]
    * Home feed Screen
    - (Read/GET)Query all walls that the user follows
    ```
        PFQuery *query = [PFQuery queryWithClassName:@"Wall"];
        [query includeKey:@"user"];
        [query whereKey:@"school" equalTo:@"Stanford"];
        [query orderByDescending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *walls, NSError *error) {
        if (walls != nil) {
            NSLog(@"Retrieved walls successfully!!");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    ```
    
    - (Create/WALL) Create new like on wall 
    ```
    PFQuery *query = [PFQuery queryWithClassName:@"Wall"];
    [query getObjectInBackgroundWithId:@"WALL_USER_ID" block:^(PFObject *wall, NSError *error) {
    if (!error) {
        // Success!
        // update like count for that user
    } else {
        // Failure!
    }
    }];
    - (Create/WALL) Create new comment on wall 
        - Similar to above
    
    - (Delete) Remove existing like or comment
        - PFQuery *query = [PFQuery queryWithClassName:@"Wall"];
            [query getObjectInBackgroundWithId:@"WALL_USER_ID" block:^(PFObject *wall, NSError *error) {
            if (!error) {
                // Success!
                // remove like for user (given previous like)
            } else {
                // Failure!
            }
            }];
     ```       

* My Wall Screen
    - (Create/WALL) Create new wall 
    ```
    PFObject *newWall = [PFObject objectWithClassName:@"Wall"];
    newWall[@"text"] = self.messageField.text;
    newWall[@"user"] = PFUser.currentUser;
    [newWall saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (succeeded) {
                NSLog(@"The wall was saved!");
            } else {
                NSLog(@"Problem saving wall: %@", error.localizedDescription);
            }
        }];
    ```
        
    - (Update/WALL) Edit wall
    ```
        PFQuery *query = [PFQuery queryWithClassName:@"Wall"];
        [query getObjectInBackgroundWithId:@"WALL_USER_ID"
                                     block:^(PFObject *wall, NSError *error) {
            // change wall details
            [wall saveInBackground];
        }];
    ```
        
    - (Delete/WALL) Remove existing wall
    
* Profile Screen
    - (Read/GET)Query logged in user object
    ```
        PFUser *currentUser = [PFUser currentUser];
            if (currentUser) {
                // retrieve information
            } else {
                // do something else
            }
    ```
    - (Update/PUT) Update user profile image
    ```
        PFUser *user = [PFUser currentUser];
            user[@"profilePicture"] = [self getPFFileFromImage:self.profilePicture.image];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"This worked!");
                }
            }];
    ```
    
##DEMO GIFS
###User can login, register and sign out
<img src='https://imgur.com/FLHhQ3V.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

###User can add images to dorm room wall
<img src='https://imgur.com/kC1aT1n.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

###User can view location functionalities(current location, other location displayed on wall)
###User can track location in real time
<img src='https://imgur.com/h1LCfbi.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

###User can view and like walls
###Like restrictions
<img src='https://imgur.com/HHMxT79.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://imgur.com/D5QVdHl.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


