import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

cred = credentials.Certificate("PATH TO THE JSON PRIVATE KEY")

# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://DATABASE_NAME.firebaseio.com'
})

# As an admin, the app has access to read and write all data, regradless of Security Rules
ref = db.reference()
users_ref = ref.child('users')

# Writing to mocked database
users_ref.set({
    'alanisawesome': {
        'date_of_birth': 'test',
        'full_name': 'test'
    },
    'gracehop': {
        'date_of_birth': 'December 9, 1906',
        'full_name': 'Grace Hopper'
    }
})

# Writing from mocked database
another_ref = db.reference("users/alanisawesome/full_name")
print(another_ref.get())