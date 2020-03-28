import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# APP INIT USING FIREBASE PK
cred = credentials.Certificate("/Users/hrzz00hn/Downloads/velecasni-firebase-adminsdk-4k7vb-95442eedc4.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Class representing usual database structure
class User(object):
    def __init__(self, name, age, phoneNumber, contacts=[], health=[], supplies=[]):
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
        self.contacts = contacts
        self.health = health
        self.supplies = supplies

    @staticmethod
    def from_dict(source):
        # [START_EXCLUDE]
        user = User(source[u'name'], source[u'age'], source[u'phoneNumber'])

        if u'contacts' in source:
            user.contacts = source[u'contacts']

        if u'health' in source:
            user.health = source[u'health']

        if u'supplies' in source:
            user.supplies = source[u'supplies']

        return user
        # [END_EXCLUDE]

    def to_dict(self):
        # [START_EXCLUDE]
        dest = {
            u'name': self.name,
            u'age': self.age,
            u'phoneNumber': self.phoneNumber,
            u'contacts':self.contacts
        }

        if self.contacts:
            dest[u'contacts'] = self.contacts

        if self.populhealthation:
            dest[u'health'] = self.health

        if self.supplies:
            dest[u'supplies'] = self.supplies

        return dest
        # [END_EXCLUDE]

    def __repr__(self):
        return(
            u'Users(name={}, age={}, phoneNumber={}, contacts={}, health={}, supplies{})'
            .format(self.name, self.age, self.phoneNumber, self.contacts,
                    self.health, self.supplies))


# Displaying data from document
doc_ref = db.collection(u'users').document(u'Z41UXoPcJ4wRDIcLE1CK')

try:
    doc = doc_ref.get()
    print(u'Document data: {}'.format(doc.to_dict()))
except google.cloud.exceptions.NotFound:
    print(u'No such document!')

# Displaying data from collection
docs = db.collection(u'users').document(u'Z41UXoPcJ4wRDIcLE1CK').collection('contacts').stream()

for doc in docs:
    print(u'{} => {}'.format(doc.id, doc.to_dict()))

# Displaying 2nd lvl document data
doc_ref_contacts = db.collection(u'users').document(u'Z41UXoPcJ4wRDIcLE1CK').collection('contacts').document('0955559355')
doc = doc_ref_contacts.get()
print(u'Document data: {}'.format(doc.to_dict()))

# Queries with condition
docs = db.collection(u'users').where(u'age', u'<', 25).stream()
for doc in docs:
    print(u'{} => {}'.format(doc.id, doc.to_dict()))