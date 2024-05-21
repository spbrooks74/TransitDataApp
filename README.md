# TransitDataApp

This web application uses Mapbox to display the positions of buses along Route 1 for the MBTA. 

Created a MySQL database in a Docker container to store data returned by the MBTA API.
Made calls to the MBTA API for Route 1 periodically (every 10 seconds). 
Parseed the JSON results returned and stored the data in a MySQL database for further analysis.
Performed change data capture (CDC) on the MySQL database with Debezium and a Maven SpringBoot App. 
Application monitored the MySQL database for changes and propagated any changes to the MongoDB database.
Fired up a Flask Web Server

![image](https://github.com/spbrooks74/TransitDataApp/assets/155562862/5e85f117-4ba3-409a-82e3-9ad80f8e5a16)

![image](https://github.com/spbrooks74/TransitDataApp/assets/155562862/76fab0e3-b8fd-4c76-a00a-edc8d84684d3)
