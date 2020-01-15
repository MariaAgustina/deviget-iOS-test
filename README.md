# Project information

## Introduction

This project runs on Xcode 11.

## Architecture

- This project was based on the model view controller design pattern
- I used a native UISplitViewController provided by apple and customized it according to the needs of the project

## MVP

Some features were left out because I preferred to obtain a minimum viable product that works well and robust.
The features that were left out are:

- Pull to Refresh
- Pagination support
- Saving pictures in the picture gallery
- Dismiss All Button (remove all posts. Animations required)
- Also the app preservation status does not support the unread/read posts and the deleted posts from the table
- I would love to do more unit tests but time was too short
- Some assets are missing: dismiss and right arrow assets

## Other notes

- In this project is exposed the client id (in order to get it working in any computer), but in the real world, this must not happen. There must be a login system that provides the user token to do the requests against the server.
- I found this url https://ssl.reddit.com/r/popular/top.json that has good material for posts to show in the application
