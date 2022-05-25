var express = require('express');
var MongoClient = require('mongodb').MongoClient;
var bodyParser = require('body-parser');


var url = 'mongodb://localhost:27017';
var api = express();


// parse application/x-www-form-urlencoded
api.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
api.use(bodyParser.json())

api.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});


api.get('/', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("FTCTeams").find({}).toArray(function(err, docs) {
      if (err) throw err;
    //  console.log(docs);
      db.close();
      res.send(docs);
    });
  });

  
});

api.get('/PensamentoCriativo', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("PensamentoCriativo").find({}).toArray(function(err, docs) {
      if (err) throw err;
     // console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.get('/Conexao', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("Conexao").find({}).toArray(function(err, docs) {
      if (err) throw err;
    //  console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.get('/Inovacao', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("Inovacao").find({}).toArray(function(err, docs) {
      if (err) throw err;
     // console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.get('/Design', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("Design").find({}).toArray(function(err, docs) {
      if (err) throw err;
    //  console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.get('/Motivacao', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("Motivacao").find({}).toArray(function(err, docs) {
      if (err) throw err;
   //   console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.get('/Controle', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
    dbo.collection("Controle").find({}).toArray(function(err, docs) {
      if (err) throw err;
    //  console.log(docs);
      db.close();
      res.send(docs);
    });
  });

});

api.post('/PremiarTime/:award', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
   
    var myquery = { value: req.body.value};
    var newvalues = { $set: {premiado: req.body.awardStatus } };

    dbo.collection(req.params.award).updateOne(myquery, newvalues, function(err, res) {

    console.log(req.body);
  });
  
  });

});


api.post('/OrdemTime/:award', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
   
    var myquery = { value: req.body.value};
    var newvalues = { $set: {position: req.body.position } };

    dbo.collection(req.params.award).updateOne(myquery, newvalues, function(err, docs) {

    console.log(req.body);

    db.close();
    res.send(docs);


  });
  
  });

});




/*api.post('/PremiarTime/Conexao', function (req, res) {
  
  MongoClient.connect(url, function(err, db,) {
    if (err) throw err;
    var dbo = db.db("FTCJugdes");
   
    var myquery = { value: req.body.value};
    var newvalues = { $set: {premiado: req.body.awardStatus } };

    dbo.collection('Conexao').updateOne(myquery, newvalues, function(err, res) {

    console.log(req.body);
  });
  
  });

});
*/
  api.post('/AdicionarTime', function (req, res) {
  
    MongoClient.connect(url, function(err, db,) {
      if (err) throw err;
      var dbo = db.db("FTCJugdes");
      dbo.collection('FTCTeams').insert(req.body);
      console.log(req.body);
      res.send(req.body);
    });
    
    });


  api.post('/Indicacao/PensamentoCriativo', function (req, res) {
  
    MongoClient.connect(url, function(err, db,) {
      if (err) throw err;
      var dbo = db.db("FTCJugdes");
      dbo.collection('PensamentoCriativo').insert(req.body);
   //   console.log(req.body);
     res.send(req.body);
    });
    
    });

    api.post('/Indicacao/Conexao', function (req, res) {
  
      MongoClient.connect(url, function(err, db,) {
        if (err) throw err;
        var dbo = db.db("FTCJugdes");
        dbo.collection('Conexao').insert(req.body);
      //  console.log(req.body);
        res.send(req.body);
      });
      
      });

      api.post('/Indicacao/Inovacao', function (req, res) {
  
        MongoClient.connect(url, function(err, db,) {
          if (err) throw err;
          var dbo = db.db("FTCJugdes");
          dbo.collection('Inovacao').insert(req.body);
      //    console.log(req.body);
          res.send(req.body);
        });
        
        });

        api.post('/Indicacao/Design', function (req, res) {
  
          MongoClient.connect(url, function(err, db,) {
            if (err) throw err;
            var dbo = db.db("FTCJugdes");
            dbo.collection('Design').insert(req.body);
          //  console.log(req.body);
            res.send(req.body);
          });
          
          });

          api.post('/Indicacao/Motivacao', function (req, res) {
  
            MongoClient.connect(url, function(err, db,) {
              if (err) throw err;
              var dbo = db.db("FTCJugdes");
              dbo.collection('Motivacao').insert(req.body);
            //  console.log(req.body);
              res.send(req.body);
            });
            
            });

            api.post('/Indicacao/Controle', function (req, res) {
  
              MongoClient.connect(url, function(err, db,) {
                if (err) throw err;
                var dbo = db.db("FTCJugdes");
                dbo.collection('Controle').insert(req.body);
             //   console.log(req.body);
                res.send(req.body);
              });
              
              });
  
api.listen(3000, function () {
  console.log('API FTC Brasil');
});
