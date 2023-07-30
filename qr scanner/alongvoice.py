import cv2
import pyzbar.pyzbar as pyzbar
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import datetime
import pyttsx3

# Use your own Firebase credentials file
cred = credentials.Certificate("path/to/firebase-credentials-file.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Create an instance of the Text-to-Speech engine
engine = pyttsx3.init()

# Set the properties for the Text-to-Speech engine
engine.setProperty('rate', 150)  # Speed of the voice
engine.setProperty('volume', 1)  # Volume of the voice

# Create a border for the scanner
border_size = 50
border_color = (0, 255, 0)  # Green
border_thickness = 2

cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    decoded_objects = pyzbar.decode(frame)
    
    # Add a border to the scanner
    frame = cv2.copyMakeBorder(frame, border_size, border_size, border_size, border_size, cv2.BORDER_CONSTANT, value=border_color)
    
    for obj in decoded_objects:
        # Check if the decoded object is a QR code
        if obj.type == "QRCODE":
            # Decode the data in the QR code
            qr_data = obj.data.decode()
            qr_date = datetime.datetime.strptime(qr_data[-26:], '%Y-%m-%d %H:%M:%S')
            qr_id = qr_data[:-26]
            
            # Check if the QR code data exists in the Firebase database
            qr_doc = db.collection("qrcodes").document(qr_id).get()
            if qr_doc.exists:
                qr_data_dict = qr_doc.to_dict()
                db_date = datetime.datetime.strptime(qr_data_dict['date'], '%Y-%m-%d %H:%M:%S')
                if qr_date >= db_date:
                    print("Allowed")
                    engine.say("Allowed")
                    engine.runAndWait()
                    # Add the allowed QR code data to the Firebase database
                    allowed_data = {'qr_id': qr_id, 'date': str(datetime.datetime.now())}
                    db.collection("entries").add(allowed_data)
                else:
                    print("Event not yet started")
                    engine.say("Event not yet started")
                    engine.runAndWait()
            else:
                print("No Data Found")
                engine.say("No Data Found")
                engine.runAndWait()
    
    cv2.imshow("QR Code Scanner", frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
