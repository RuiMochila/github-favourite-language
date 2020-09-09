# README

This is a sample app showcasing some functionalities of Ruby on Rails.


It contains a page where we can type a username from Github, to guess that user's favourite programming language.


The form is submitted using JS, the request calls an ActiveJob to guess some user's favourite language, and responds with a placeholder in the meantime. 


The background job calls a service object to make a GraphQL query to Github's API for that user's public repos. Because I'm using GraphQL, I'm able to just retrieve the primaryLanguage for each repo the user has, reducing the request payload. 


When I'm finished gathering the data and calculating the favourite language, I issue a `cable_ready` event in order to update the front end, by re-rendering that partial through the websocket connection.   


For this to work, it's required that you provide a `GITHUB_ACCESS_TOKEN` environment variable, with `public_repo` scope. 

