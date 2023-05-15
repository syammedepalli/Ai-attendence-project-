from flask import Flask, request, jsonify
import cv2
import os
from flask import Flask,request,render_template
from datetime import date
from datetime import datetime
import numpy as np
from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
import joblib


app = Flask(__name__)



def datetoday():
    return date.today().strftime("%m_%d_%y")
def datetoday2():
    return date.today().strftime("%d-%B-%Y")
#### Initializing VideoCapture object to access WebCam
face_detector = cv2.CascadeClassifier(r"C:\Users\syamm\OneDrive\Desktop\face\static\haarcascade_frontalface_default.xml")
cap = cv2.VideoCapture(0)
#### If these directories don't exist, create them
if not os.path.isdir('Attendance'):
    os.makedirs('Attendance')
if not os.path.isdir('static/faces'):
    os.makedirs('static/faces')
if f'Attendance-{datetoday()}.csv' not in os.listdir('Attendance'):
    with open(f'Attendance/Attendance-{datetoday()}.csv','w') as f:
        f.write('Name,Date,Roll,Start Time,End Time')
#### get a number of total registered users
def totalreg():
    return len(os.listdir(r"C:\Users\syamm\OneDrive\Desktop\face\static\faces"))
#### extract the face from an image
def extract_faces(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    face_points = face_detector.detectMultiScale(gray, 1.3, 5)
    return face_points
    print(face_points)
#### Identify face using ML model
def identify_face(facearray):
    model = joblib.load(r"C:\Users\syamm\OneDrive\Desktop\face\static\face_recognition_model.pkl")
    return model.predict(facearray)
#### A function which trains the model on all the faces available in faces folder
def train_model():
    faces = []
    labels = []
    userlist = os.listdir(r"C:\Users\syamm\OneDrive\Desktop\face\static\faces")
    for user in userlist:
        for imgname in os.listdir(f'{user}'):
            img = cv2.imread(f'static/faces/{user}/{imgname}')
            resized_face = cv2.resize(img, (50, 50))
            faces.append(resized_face.ravel())
            labels.append(user)
    faces = np.array(faces)
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(faces,labels)
    joblib.dump(knn,r"C:\Users\syamm\OneDrive\Desktop\face\static\face_recognition_model.pkl")
#### Extract info from today's attendance file in attendance folder
def extract_attendance():
    try:
        df = pd.read_csv(f'Attendance/Attendance-{datetoday()}.csv')
        names = df['Name']
        date=df['Date']
        rolls = df['Roll']
        times = df['Start Time']
        etime = df['End Time']
        l = len(df)
        return names,date,rolls,times,etime,l
    except pd.errors.EmptyDataError:
        print("Error: File contains no data or columns.")
        return None, None, None, None, 0
  #### Add Attendance of a specific user
def add_attendance(name):
    username = name.split('_')[0]
    userid = name.split('_')[1]
    current_date=date.today()
    current_time = datetime.now().strftime("%H:%M:%S")
   
    try:
        df = pd.read_csv(f'Attendance/Attendance-{datetoday()}.csv')
    except pd.errors.EmptyDataError:
        print("Error: File contains no data or columns.")
        return
   
    if int(userid) not in list(df['Roll']):
        with open(f'Attendance/Attendance-{datetoday()}.csv','a') as f:
            f.write(f'\n{username},{current_date},{userid},{current_time}')
    else:
        idx = df[df['Roll']==int(userid)].index.values[0]
        df.loc[idx, 'End Time'] = current_time
        df.to_csv(f'Attendance/Attendance-{datetoday()}.csv', index=False)


#### This function will run when we click on Take Attendance Button
@app.route('/api', methods = ['GET'])
def start():
    if 'face_recognition_model.pkl' not in os.listdir(r"C:\Users\syamm\OneDrive\Desktop\face\static"):
        print('There is no trained model in the static folder. Please add a new face to continue.')
        return

    cap = cv2.VideoCapture(0)
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        faces = extract_faces(frame)
        if len(faces) > 0:
            (x, y, w, h) = faces[0]
            center=(int(x+w/2),int(y+h/2))
            radius=int(min(w,h)/2)
            cv2.circle(frame, center,radius, (0, 0, 255), 2)
            face = cv2.resize(frame[y:y+h, x:x+w], (50, 50))
            identified_person = identify_face(face.reshape(1, -1))[0]
            add_attendance(identified_person)
            cv2.putText(frame, f'--->Authorized: {identified_person}', (400,300), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
        cv2.imshow('Attendance', frame)
        if cv2.waitKey(1) == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
    names,date,rolls,times,etime,l = extract_attendance()
    '''d={}
    inputchr = str(request.args['query'])
    if inputchr == "1":
        d['Status'] = "Authorized Successful"
    else:
        d['Status'] = 10
    return d'''
    d={}
    d['Status'] = "Authorized Successful"
   
    return d




if __name__ =="__main__":
    app.run()
