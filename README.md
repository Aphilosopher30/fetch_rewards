# README

Languages and Frameworks:
- Ruby Version 2.5.3
- Rails Version 5.2.7


Set Up Instructions:

   a. From in the github repository, copy the ssh key "git@github.com:Aphilosopher30/fetch_rewards.git"

   b. Use what you copied in your terminal by entering ```$ git clone git@github.com:Aphilosopher30/quiz_app.git```

   c. Enter into the folder that you just cloned, probably by entering $ cd quiz_app

   d. In terminal run the bundler: ```$ bundler``` or ```$ bundle install```

   e. To start server terminal run ```$ rails s```, or ```$ rails server```



END POINTS: There are three endpoints in this App. A. One which creates a new transaction, B. One which spends points, C. One which reports the payers and their balances. When you call these endpoints you may need to provide a JSON object in the Body of the http request.


A. Create Transaction: this end point creates and saves a new transaction. It receives information on how the transaction is to be created in JSON format. (Note: If you do not provide an appropriate DateTime object for the timestamp, then it will generate it's own timestamp.) It returns information on the transaction that has just been created.

   URL: ```get 'user/transactions/new' ```

  body: ```{"payer": String, "points": Integer,  "timestamp": DateTime}```

  returns => ```{"data": {
      "id": null,
      "type": "transaction",
      "attributes": {
        "payer": String
        "points": Integer
        "timestamp": DateTime
        }
      }
    }```

B. Spend Points: This endpoint receives  an integer packaged in a json object, that represents how many points are to be spent. It then creates new transactions that subtract points equal to the number of points spent. It spends the oldest points first. It then returns a JSON object that specifies which payers have which points subtracted from their total. In the event that there are not enough points to spend, then it will return an error.

  URL: ```get 'user/transactions/spend'```

  body: ```{"points": Integer}```

  returns => ```[
    {
      "payer": String,
      "points": Integer
    },
    {
      "payer": "String",
      "points": Integer
    }
  ]```

OR    
  returns => ```{"error": "insufficent funds"}```


C. List Payer Balances: This provides a JSON object that lists each payer, and how and how many points the user currently has from that payer. It does not require any input in the body.

  URL: ```get '/user/payers'```

  returns => ```{
    payer_name1: Integer
    payer_name2: Integer
    payer_name3: Integer
  }```
