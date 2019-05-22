var express=require("express");
var mysql=require("mysql");
const PORT = process.env.PORT || 3306
var session = require('express-session');
var bodyParser=require("body-parser");
var app=express();

var email='',page='',usertype='',count=0;

app.set("view engine","ejs");
app.use(bodyParser.urlencoded({extended:true}));

app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(express.static("public"));


var connection = mysql.createConnection({
  host     : 'remotemysql.com',
  user     : 'BnZJWCik56', 
  password : 'Q7Uw03MJP9',
  database : 'BnZJWCik56'  
});


Coordinator_No();

function Coordinator_No(){
var q="SELECT COUNT(*) AS count FROM users WHERE User_type='C'";
connection.query(q,function(error,result,fields){
    if(error) throw error;
    count=result[0].count;
});
}

app.get("/",function(req,res){
   res.render("home",{email:email,usertype:usertype}); 
});

app.get("/register",function(req,res){
   res.render("register",{count:count}); 
});

app.get("/events",function(req,res){
   res.render("events"); 
});

app.get("/contact",function(req,res){
   res.render("contact"); 
});

app.get("/cv",function(req,res){
   if(email){
        if(usertype!=='P')
            res.render("cv");
        else
            res.send("This page is only for Management team");
        }
    else{
        page="cv";
        res.render("login");
    } 
});

app.get("/gullycricket",function(req,res){
    if(email)
        res.render("gullycricket");
    else{
        page="gullycricket";
        res.render("login");
    }
});

app.get("/futsal",function(req,res){
    if(email)
        res.render("futsal");
    else{
        page="futsal";
        res.render("login");
    }
});

app.get("/generalquiz",function(req,res){
    if(email)
        res.render("generalquiz");
    else{
        page="generalquiz";
        res.render("login");
    }
});

app.get("/captureflag",function(req,res){
    if(email)
        res.render("captureflag");
    else{
        page="captureflag";
        res.render("login");
    }
});

app.get("/coderelay",function(req,res){
    if(email)
        res.render("coderelay"); 

    else{
        page="coderelay";
        res.render("login");
    }
});

app.get("/login",function(req,res){
   res.render("login");
});

app.get("/logout",function(req,res){
    req.session.destroy(function(err) {
        if(err) throw err;
        email='';
        page='';
        res.redirect("/");
   });
});



app.post("/registration",function(req,res){
    var user={
        Name:req.body.name,
        Email:req.body.email,
        Password:req.body.password,
        User_type:req.body.user_type,
        Institution:req.body.institution,
        Contact:req.body.contact
    };
    
connection.query('INSERT INTO users SET?',user,function(error,result)
{
    if(error)
    {
        if(error.code ==='ER_DUP_ENTRY'){
            res.send("Email already exists");
        }
    }    
    else{
        Coordinator_No();
        res.send("You have succesfully registered");
    }
    });
});
 
app.post("/mteam",function(req, res) {
    if(email)
    {
        var evID=req.body.ev_id;
        var q='SELECT * FROM users where Email=?';
        connection.query(q,email,function(error,result,fields){
        if(error) throw error;
        EventCheck(result[0].User_ID,result[0].User_type,evID);
        });
    }
    else{
        page="cv";
        res.render("login");
    }
    function EventCheck(uid,utype,evid)
    {
        if(utype=='V')
        {
            var v={
                User_ID:uid,
                Event_ID:evid,
                Role:utype
            };
            connection.query('INSERT INTO fm_team SET ?',v,function(error, result) {
                if(error)
                {
                    if(error.code==='ER_DUP_ENTRY')
                    {
                        res.send("You are already Volunteering");
                    }
                }
                else
                {
                    res.send("succesfully taken event");
                }
                    
            });
        }
        else
        {
            var check="SELECT * FROM fm_team WHERE Event_ID=? AND Role='C'";
            connection.query(check,evid,function(error, result,fields) {
                if(error) throw error;
                if(result.length>0)
                {
                    res.send("Event already taken By Other Coordinator");
                }
                else{
                InsertCoordinator();
                }
            });
            function InsertCoordinator()
            {
                var c={
                User_ID:uid,
                Event_ID:evid,
                Role:utype
                };
                connection.query('INSERT INTO fm_team SET ?',c,function(error, result) {
                if(error)
                {
                    if(error.code==='ER_DUP_ENTRY')
                    {
                        res.send("You are Already Organising Other event");
                    }
                }
                else{
                res.send("Thanks for coordinating");
                }
                });
            }
        }
    }
});  


app.post("/participation",function(req, res) 
{
    
    if(email)
    {
        var evID=req.body.ev_id;
        var q='SELECT * FROM users where Email=?';
        connection.query(q,email,function(error,result,fields){
            if(error) throw error;
            setValue(result[0].User_ID,result[0].User_type,evID);
    });
    
    function setValue(user,utype,evid) 
    {
        if(utype==='P')
        {
            var p={
            User_ID:user,
            Event_ID:evid
            };
             connection.query('INSERT INTO participants SET ?',p,function(error, result) {
                if(error)
                {
                    if(error.code==='ER_DUP_ENTRY')
                    {
                        res.send("You Have Already Participated");
                    }
                }
                else
                {
                    res.send("succesfully participated");
                }
                    
                });
        }
        else{
            res.send("You are not a participant");
        }
    }
    }
    else{
        res.render("login");
    }
});

app.post("/4pteam",function(req, res) 
{
    var ev=req.body.ev_id;
    var p2=req.body.m2;
    var p3=req.body.m3;
    var p4=req.body.m4;
    
    var q= 'SELECT * FROM users where Email=?';
    connection.query(q,email,function(error, result, fields) {
        if(error) throw error;
        
         CheckParticipant(result[0].User_ID,result[0].User_type);
    });    
   
    function CheckParticipant(p1,utype)
    {
        var k=0;
        var q1='SELECT User_type from users where User_ID=?';
        if(k==0)
        {
            if(utype!='P'){
                k=1;
                res.send("You are not a participant");
                res.end();
            }
        }
        
        if(k!=1)
        {
            connection.query(q1,p2,function(error,result,fields){
                if(error) throw error;
                if(result.length>0)
                {
                    if(result[0].User_type!='P'){
                    k=1;
                    res.send(" Member 2 is not a participant");
                    }
                }
                else{
                    k=1;
                    res.send("Member 2 has not registered");
                }
            });
        }
        if(k!=1)
        {
            connection.query(q1,p3,function(error,result,fields){
                if(error) throw error;
                if(result.length>0)
                {
                if(result[0].User_type!='P'){
                k=1;
                    res.send("Member 3 is not a participant");
                }
                }
                 else{
                    k=1;
                    res.send("Member 3 has not registered");
                 }
            });
        }
        if(k!=1)
        {
            connection.query(q1,p4,function(error,result,fields){
                if(error) throw error;
                if(result.length>0)
                {
                if(result[0].User_type!='P'){
                     k=1;
                     res.send("Member 4 is not a participant");
                }
                else{
                 xyz(k);
                }
                }
                else
                    res.send("Member 4 has not registered");
            });
        }
        function xyz(k)
        {
            if(k==0){
                 InsertParticipants(p1);
            }
        }
    }
    
    
    function InsertParticipants(p1)
    {
        if(p1 != p2 && p1 !=p3 && p1 !=p4 && p2!=p3 && p2!=p4 && p3!=p4){
         var team={
            P1_ID:p1,
            P2_ID:p2,
            P3_ID:p3,
            P4_ID:p4,
            event_id:ev
            };
            connection.query('INSERT INTO p_team SET ?', team , function(error, result) {
            if(error)
            {  
                if(error.code==='ER_DUP_ENTRY')
                {
                    res.send("Already participated");
                }
            }
            else
            {
                res.send("succesfully participated");
            }
            
            });
        }
        else{
             res.send("Enter unique members id");
        }
    }
});


app.post("/2pteam",function(req, res) 
{
    var ev=req.body.ev_id;
    var p2=req.body.m2;
    
    var q= 'SELECT * FROM users where Email=?';
    connection.query(q,email,function(error, result, fields) {
        if(error) throw error;    
         CheckParticipant(result[0].User_ID,result[0].User_type);
    });    
   
    function CheckParticipant(p1,utype)
    {
        var k=0;
        var q1='SELECT User_type from users where User_ID=?';
        if(k==0)
        {
            if(utype!='P'){
                k=1;
                res.send("You are not a participant");
                res.end();
            }
        }
        
        if(k!=1)
        {
            connection.query(q1,p2,function(error,result,fields){
                if(error) throw error;
                if(result.length>0)
                {
                    if(result[0].User_type!='P'){
                         k=1;
                        res.send("Not a participant");
                    }
                    else{
                        xyz(k);
                    }
                }
                else{
                    k=1;
                    res.send("Member 2 has not registered ");
                }
            });
        }
        function xyz(k)
        {
            if(k==0){
                 InsertParticipants(p1);
            }
        }
    }
    
    
    function InsertParticipants(p1)
    {
        if(p1 != p2){
         var team={
            P1_ID:p1,
            P2_ID:p2,
            event_id:ev
            };
            connection.query('INSERT INTO p_team SET ?', team , function(error, result) {
            if(error)
            {  
                if(error.code==='ER_DUP_ENTRY')
                {
                    res.send("Already participated");
                }
            }
            else
            {
                res.send("succesfully participated");
            }
            
            });
        }
        else{
             res.send("Enter unique members id");
        }
    }
});


app.post('/login_request', function(request, response) {
    email = request.body.email;
	var password = request.body.password;
	if (email && password) {
		connection.query('SELECT * FROM users WHERE Email = ? AND Password = ?', [email, password], function(error, results, fields) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.email = email;
				usertype=results[0].User_type;
				if(page===''){
                     response.redirect("/");
                }
                else
                {
                     response.redirect("/"+page);
                }
			}
			else {
			    email='';
    			response.send('Incorrect Username and/or Password!');
			}			
			response.end();
		});
	} 
	else 
	{
		response.send('Please enter email and Password!');
		response.end();
	}
});

app.listen(PORT,(()=>{
    console.log("server listening");
}));
