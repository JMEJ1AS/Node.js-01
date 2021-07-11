// 1 - Invocamos a express
const express = require('express')
const app = express()
const server = require('http').Server(app)
const io = require('socket.io')(server)

// 2 - steamos urlenconded para capturar los datos del formulario
app.use(express.urlencoded({extended:false}));
app.use(express.json());

// 3 - Invocamos a dotenv
const dotenv = require('dotenv');
dotenv.config({path:'./env/.env'});

// 4 - El directorio public
app.use('/resources', express.static('public'));
app.use('/resources', express.static(__dirname + '/public'));

// 5 - Establecemos el motor de plantillas
app.set('view engine', 'ejs');

// 6 - Invocamos a bcryptjs
bcryptjs = require("bcryptjs");
bcrypt = require("bcrypt");

// 7 - Var. de session
const session = require('express-session');
app.use(session({
    secret:'secret',
    resave: true,
    saveUninitialized: true
}));

// 8 - Invocamos al módulo de conexión de la BD
const connection = require('./database/db');

// 9 - Estableciendo las rutas
/*app.get('/', (req, res)=>{
    //res.send('Hola Mundo');
    res.render('index', {msg: 'ESTO ES UN MENSAJE DESDE NODE'});
})*/

app.get('/login', (req, res)=>{
    res.render('login');
})

app.get('/register', (req, res)=>{
    res.render('register');
})

// 10 - Registro
app.post('/register', async (req, res)=>{
    const user = req.body.user;
    const name = req.body.name;
    const rol = req.body.rol;
    const password = req.body.password;

    //let passwordHaash = await bcryptjs.hash(password, 8);

    var hash = bcryptjs.hashSync(password, 8);

    connection.query('INSERT INTO users SET ?', {user:user, name:name, rol:rol, pass:hash}, async(error, results)=>{
        if(error){
            console.error(error);
        } else {
            res.render('register',{
                alert: true,
                alertTitle: "Registro",
                alertMessage: "¡Successful Regestration!",
                alertIcon:'success',
                showConfirmButton:false,
                timer:1500,
                ruta:''
            })
        }
    })
})

// 11 - Autenticación
app.post('/auth', async (req, res)=>{
    const user = req.body.user;
    const pass = req.body.pass;
    let hash = await bcryptjs.hash(pass, 8);
    if(user && pass){
        connection.query('SELECT * FROM users WHERE user = ?', [user], async (error, results)=>{
            if(results.length == 0 || !(await bcryptjs.compare(pass, results[0].pass))){
                res.render('login',{
                    alert: true,
                    alertTitle: "Error",
                    alertMessage: "Usuario y/o password incorrectas",
                    alertIcon:'error',
                    showConfirmButton:true,
                    timer:false,
                    ruta:'login'
                })
            } else {
                req.session.loggedin = true;
                req.session.name = results[0].name;
                res.render('login',{
                    alert: true,
                    alertTitle: "Conexion exitosa",
                    alertMessage: "¡LOGIN CORRECTO !",
                    alertIcon:'success',
                    showConfirmButton:false,
                    timer:1500,
                    ruta:''
                })
            }
        })
    } else {
        res.render('login',{
            alert: true,
            alertTitle: "Advertencia",
            alertMessage: "¡Por favor ingrese un usuario y/o password! !",
            alertIcon:'warning',
            showConfirmButton:true,
            timer:1500,
            ruta:'login'
        })
    }


}) 

// 12 -  Auth Pages
app.get('/', (req,res)=>{
   
    if(req.session.loggedin){
        res.render('index',{
            login: true,
            name: req.session.name
        })
    } else {
    
        res.render('login')
    
    }
        /*
    else {
        res.render('index',{
            login: false,
            name: 'Debe iniciar sesión'
        })
    }*/

})

// 13 - Logout
app.get('/logout', (req, res)=>{
    req.session.destroy(()=>{
        res.redirect('login')
    })
})


server.listen(3000, (req, res)=>{
    console.log('SERVER RUNING IN http://localhost:3000');
})

io.sockets.on('connection', function (socket) {

    setInterval(()=>{
    
        console.log('a client connected');

        connection.query('SELECT * FROM correos ORDER BY fecha DESC',function(err,rows){
        if(err) throw err;
        console.log('Data received from Db:\n');
        console.log(rows);
        socket.emit('showrows', rows);
        });
    
    }, 3000)
    
});