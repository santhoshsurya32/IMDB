Controllers
1.Producer
2.Actor
3.Movie


1.Producer
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1.1 API-AddOrUpdateProducer

Request Type : POST

url:-/api/Producer/AddOrUpdateProducer

Description:- For Adding and Updating the producer and their Details.For Adding Producer ProducerId must be 0.
For Updating the Producer Prepopulate Api need to used for fetching the details and then respective ProducerId 
need to pass along with updated details.

For Adding Producer

Request
{
  "producerId": 0,
  "producerName": "Sivakarthikeyan",
  "bio": "actor cum Producer",
  "dob": "1990-11-21",
  "gender": "male", //only accepts male,female or others in either case.
  "company": "SK"
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

For Updating Producer

Fetch list of producers using GetProducersList API and using that ProducerId Get all details using GetProducerDetail API
and Update the Detail As per requirement.

Request
{
  "producerId": 14,
  "producerName": "Sivakarthikeyan",
  "bio": "actor cum Producer",
  "dob": "1980-11-21",
  "gender": "male",//only accepts male,female or others in either case.
  "company": "SK"
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

1.2 API-GetProducersList - To get list of producers to add/update a movie

RequestType:- GET
url:-/api/Producer/GetProducersList
Request{
searchText:""  //Optional
}
Response
{
  "result": {
    "name": "ProducersList",
    "producers": [
      {
        "value": 12,
        "name": "kalanithi maran"
      },
      {
        "value": 13,
        "name": "Udhayanidhi Stalin"
      },
      {
        "value": 14,
        "name": "Sivakarthikeyan"
      }
    ]
  },
  "errors": null,
  "message": null
}

1.3 API-DeleteProducer - To Delete a producer

RequestType:- PUT
url:-/api/Producer/DeleteProducer
Request{
producerId:-14
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

1.4 API-GetProducerDetails - to Fetch Producer Details based on producerId for updating the details (Prepopulate)

RequestType:- GET
url:-/api/Producer/GetProducerDetails
Request{
producerId:-14
}

Response
{
  "result": {
    "producerId": 13,
    "producerName": "Udhayanidhi Stalin",
    "bio": "prod",
    "dob": "1995-11-20T03:10:00.743",
    "gender": "MALE", //only accepts male,female or others in either case.
    "company": "Red Giant Movies"
  },
  "errors": null,
  "message": null
}

2.Actor

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

2.1 API-AddOrUpdateActor

Request Type : POST

url:-/api/Actor/AddOrUpdateActor

Description:- For Adding and Updating the actor and their Details.For Adding Actor , ActorId must be 0.
For Updating the Actor Prepopulate Api need to used for fetching the details and then respective ActorId 
need to pass along with updated details.

For Adding Actor

Request
{
  "actorId": 0,
  "actorName": "Suriya",
  "bio": "multi talented",
  "dob": "1985-11-21",
  "gender": "male" //only accepts male,female or others in either case.
}

Response
{
  "result": 7, //Actor Id
  "errors": null,
  "message": null
}

For Updating Actor

Fetch list of Actors using GetActorsList API and using that ActorId Get all details using GetActorDetail API
and Update the Detail As per requirement.

Request
{
  "actorId": 7,
  "actorName": "Suriya Sivakumar",
  "bio": "multi talented",
  "dob": "1985-11-21",
  "gender": "male"  //only accepts male,female or others in either case.
}

Response
{
  "result": 7, //Actor Id
  "errors": null,
  "message": null
}

2.2 API-GetActorsList - To get list of Actors to add/update a movie

RequestType:- GET
url:-/api/Actor/GetActorsList
Request{
searchText:""  //Optional
}
Response
{
  "result": {
    "name": "ActorsList",
    "actors": [
      {
        "value": 1,
        "name": "Rajini"
      },
      {
        "value": 4,
        "name": "Sharuk khan"
      },
      {
        "value": 5,
        "name": "Abishek bachan"
      },
      {
        "value": 6,
        "name": "Salman Khan"
      },
      {
        "value": 7,
        "name": "Suriya Sivakumar"
      }
    ]
  },
  "errors": null,
  "message": null
}

2.3 API-DeleteActor - To Delete a Actor

RequestType:- PUT
url:-/api/Producer/DeleteActor
Request{
ActorId:-3
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

2.4 API-GetActorDetails - to Fetch Actor Details based on ActorId for updating the details (Prepopulate)

RequestType:- GET
url:-/api/Actor/GetActorDetails
Request{
ActorId:-7
}

Response
{
  "result": {
    "actorId": 7,
    "actorName": "Suriya Sivakumar",
    "bio": "multi talented",
    "dob": "1985-11-21T00:00:00",
    "gender": "male"
  },
  "errors": null,
  "message": null
}


3.Movie
----------------------------
3.1 API-AddOrUpdateMovie

Request Type : POST

url:-/api/Producer/AddOrUpdateMovie

Description:- For Adding and Updating the Movie and their Details.For Adding Movie MovieId must be 0.
For Updating the Movie Prepopulate Api need to used for fetching the details and then respective MovieId 
need to pass along with updated details.

For Adding Movie

Request
{
  "movieId": 0,
  "name": "Soorarai potru",
  "plot": "Biography",
  "releaseDate": "2020-11-21",
  "producerId": 12,
  "actorId": [                    //use GetProducersList api for dropdown to select the producers
    7,6,5                         //we can also pass multiple actors at once.use GetActorsList api for dropdown to select the actors
  ]
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

For Updating Movie

Fetch list of Movie using GetMoviesList API and using that MovieId Get all details using GetMovieDetail API
and Update the Detail As per requirement.

Request
{
{
  "movieId": 7,
  "name": "Queen",
  "plot": "Biography",
  "releaseDate": "2020-11-21",
  "producerId": 12,
  "actorId": [
    7,6,5
  ]
}
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

3.2 API-GetMoviesList - To get list of movies to add/update a movie


RequestType:- GET
url:-/api/movie/GetMoviesList
Request
{
  "pageIndex": 1,
  "pageSize": 10,
  "searchText": "Q", //optional
  "actorsFilter": [
    7                      //actors Id (optional) if no Actor filter choosen send it as empty list
  ],
  "producersFilter": [
                          //producers Id (optional) if no producer filter choosen send it as empty list
  ]
}
Response
{
  "result": {
    "totalCount": 1,
    "movies": [
      {
        "movieId": 7,
        "movieName": "Queen",
        "releasedDate": "2020-11-21T00:00:00",
        "plot": "Biography",
        "producerName": "kalanithi maran",
        "actors": [
          {
            "actorId": 5,
            "actorName": "Abishek bachan"
          },
          {
            "actorId": 6,
            "actorName": "Salman Khan"
          },
          {
            "actorId": 7,
            "actorName": "Suriya Sivakumar"
          }
        ]
      }
    ]
  },
  "errors": null,
  "message": null
}

1.3 API-DeleteMovie - To Delete a movie

RequestType:- PUT
url:-/api/Movie/DeleteMovie

Request{
movieId:-5
}

Response
{
  "result": 101, //Status Code(Enum) 101 for Success.
  "errors": null,
  "message": null
}

1.4 API-GetMovieDetails - to Fetch movie Details based on movieId for updating the details (Prepopulate)

RequestType:- GET
url:-/api/Movie/GetMovieDetails

Request{
movieId:-7
}

Response
{
  "result": {
    "movieId": 7,
    "movieName": "Queen",
    "releasedDate": "2020-11-21T00:00:00",
    "plot": "Biography",
    "producerName": "kalanithi maran",
    "actors": [
      {
        "actorId": 5,
        "actorName": "Abishek bachan"
      },
      {
        "actorId": 6,
        "actorName": "Salman Khan"
      },
      {
        "actorId": 7,
        "actorName": "Suriya Sivakumar"
      }
    ]
  },
  "errors": null,
  "message": null
}