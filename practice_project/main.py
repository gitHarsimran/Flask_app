from flask import Flask, render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash ,check_password_hash
from flask_login import login_user ,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from sqlalchemy.sql import text
import pymysql
from flask_mail import Mail
import json

with open ('config.json','r') as c:
    params = json.load(c)["params"]






pymysql.install_as_MySQLdb()

# Initialize Flask app
app = Flask(__name__)
app.secret_key = "hassi"

#this is for getting unique user account
login_manager = LoginManager(app)
login_manager.login_view='Login'


#SMTP mail server settings

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=465,
    MAIL_USE_SSL= True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']

)
mail=Mail(app)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/medihelp'
db = SQLAlchemy(app)

# Define the model
class Test(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))

class User(UserMixin,db.Model):
    id = db.Column(db.Integer , primary_key =True)
    username =db.Column(db.String(60))
    email = db.Column(db.String (100))
    password = db.Column(db.String (1000))

class Patients(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    disease=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    mobile=db.Column(db.String(50))


class Nurses(db.Model):
    nid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    nurse_name=db.Column(db.String(50))
   

class Trigger(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))

#here we will pass the endpoints and run the functions




@app.route("/")
def index():
    return render_template('index.html')

@app.route("/Nurse", methods=['POST', 'GET'])
def Nurse():
    
     if request.method == "POST":
        
        email = request.form.get('email')
        nurse_name = request.form.get('nurse_name')
        

        # Insert into database
        query = Nurses(email=email, nurse_name=nurse_name)
        db.session.add(query)
        db.session.commit()

        flash("Nurse Registered", "info")
    

     return render_template('Nurse.html')

@app.route("/Patient", methods=['POST', 'GET'])
@login_required
def Patient():

    nur = db.session.execute(text("SELECT * FROM nurses"))  # Correct query
    results = nur.fetchall()  # Fetch all rows
  
       
    if request.method == "POST":
        email = request.form.get('email')
        name = request.form.get('name')
        gender = request.form.get('gender')
        slot = request.form.get('slot')
        disease = request.form.get('disease')
        time = request.form.get('time')
        date = request.form.get('date')
        mobile = request.form.get('mobile')

        # Insert into database
        query = Patients(email=email, name=name, gender=gender, slot=slot, 
                         disease=disease, time=time, date=date, mobile=mobile)
        db.session.add(query)
        db.session.commit()

        mail.send_message(
        subject='MEDIHELP',
        sender=params['gmail-user'],
        recipients=[email],
        body=f"YOUR BOOKING IS CONFIRMED! THANK YOU FOR CHOOSING MEDIHELP at {time} on {date}."
    )

        flash("Booking Confirmed", "info")
    return render_template('Patient.html' , results=results)




@app.route("/Visit")
@login_required
def Visit():
    em = current_user.email

    # Explicitly declare the SQL query as text
    query = db.session.execute(text("SELECT * FROM patients WHERE email = :email"), {"email": em})
    patients = query.fetchall()  # Fetch all matching records

    # Render the template with the fetched data
    return render_template('Visit.html', query=patients)




@app.route("/edit/<string:pid>", methods=['POST', 'GET'])
@login_required
def edit(pid):
    posts = Patients.query.filter_by(pid=pid).first()
    if request.method == "POST":
        email = request.form.get('email')
        name = request.form.get('name')
        gender = request.form.get('gender')
        slot = request.form.get('slot')
        disease = request.form.get('disease')
        time = request.form.get('time')
        date = request.form.get('date')
        mobile = request.form.get('mobile')

        # Use db.session.execute with parameterized query
        db.session.execute(
            text("""
                UPDATE patients 
                SET 
                    name = :name, 
                    email = :email, 
                    gender = :gender, 
                    slot = :slot, 
                    disease = :disease, 
                    time = :time, 
                    date = :date, 
                    mobile = :mobile 
                WHERE pid = :pid
            """),
            {"name": name, "email": email, "gender": gender, "slot": slot, "disease": disease, 
             "time": time, "date": date, "mobile": mobile, "pid": pid}
        )
        db.session.commit()  # Commit the transaction
        flash("Slot is Updated", "success")
        return redirect('/Visit')

    return render_template('edit.html', posts=posts)



@app.route("/delete/<string:pid>", methods=['POST', 'GET'])
@login_required
def delete(pid):
    db.session.execute(
        text("DELETE FROM patients WHERE pid = :pid"),
        {"pid": pid}
    )
    db.session.commit()  
    flash("Slot Deleted Successful","danger")

    return redirect('/Visit')



@app.route("/Signup", methods=['POST', 'GET'])
def Signup():
    if request.method == "POST":
        username = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')

        # Check if the user already exists
        user = User.query.filter_by(email=email).first()
        if user:
            flash("Email already exists","warning")
            return render_template('Signup.html')

        # Hash the password and create a new user
        encpass = generate_password_hash(password)
        newuser = User(username=username, email=email, password=encpass)
        db.session.add(newuser)  # Add to the session
        db.session.commit()  # Commit to the database

        flash("Signup Success Please Login" ,"success")
        return render_template('Login.html')

    return render_template('Signup.html')


@app.route("/Login", methods=['POSt' , 'GET'])
def Login():
    if request.method == "POST":
        email = request.form.get('email')
        password = request.form.get('password')
        user = User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("Login Success","primary")
            return redirect(url_for('index'))
        else:
            flash("Invalid Credentials" ,"danger")
            return render_template('Login.html')
        

    return render_template('Login.html')

@app.route("/Logout")
@login_required
def Logout():
    logout_user()
    flash("Logout Successful","success")
    return redirect(url_for('Login'))


@app.route('/details')
@login_required
def details():
    posts=Trigger.query.all()
    return render_template('trigger.html',posts=posts)


@app.route("/test")
def practice():
    try:
        Test.query.all()
        return "My database is connected"
    except Exception as e:
        return f"My database is not connected. Error: {e}"
    

# Run the app
if __name__ == "__main__":
    app.run(debug=True)
