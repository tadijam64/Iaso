# Iaso

<img width="220" height="384" src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Iaso.jpg/220px-Iaso.jpg">

Iaso or Ieso was the Greek goddess of recuperation from illness. Iaso is also an app and a smart assistant that lets friends and family stay in touch and care about each other.

# Hack Zurich
[#CodeVsCovid19](https://digitalfestival.ch/en/HACK/)

# Inspiration
With all of us having most of our family members and friends somewhere abroad, we wondered if there was a better way to stay in touch with the people we care about, and if there was a way to let them know how we're doing.

We also thought of our most vulnerable loved ones, such as our grandparents or parents, and wanted to make it easier on them to keep their worries off groceries and other supplies they'd have to go out and get for themselves, so we made it possible for their family to see exactly what they need, and when they'll need it.

# What it does
We recommend you to take a look at the video as the answer to this question, it's just a bit shy of 2 minutes and covers most of it. :) But then again, TL;DR: The app acts as a center place of keeping track of your own health, but also the health of your family and friends. You can connect with them using your phone numbers, you can request that they share their health status and diary with you, and you can share yours, and you can get informed on a daily basis using the built-in bot.

The bot part of the project scans organisations such as the WHO and the ECDC for daily updates and reports which are then analysed and the most recent information can get sent to the user, be it in the form of a daily report or through answers to various questions. It can also be used on Amazon devices as an Alexa skill. If you're interested in trying it out before it gets verified by Amazon, reach out to us and we'll add you to the beta tester list. :)

# How we built it
We divided into three smaller teams: a mobile app/flutter team, an NLP/Voice assistant/Bot team and a one-man ML team that built a model that detects cough using 1 second of audio.

# The Flutter app
The app started small but with full spead ahead. Initially we all sat down, and threw some ideas on paper what would people need today. So we came up with 2-3 core features:

I want to see how is my family doing and what do they need and what is their health situation
I want to have verified and accurate sources on the COVID and ask my questions without fear of fake news
I want to monitor my health and get recommendations on further actions
I want to have an overview of my and my family current household supplies
Thus the journey started to create all these core features into a nice design and usable tool.

Decision was made family members will add each other via phone number, and after approval will be able to see each other health and current household supplies, thus we keep each other privacy but also keep the families safe and without worries.

Health check was a challenging one, we did heavy research and consultation with mentors how to properly identify symptoms, weight them in trough proper verified mathematical analysis to give suggestions to the user should he contact health services, take some time to rest. This even ended up with Iaso reminding the user to measure his temperature again in case the user had a fever.

Iaso - one of the core features is a mixture between backend and fronted hard work. We taught Iaso to read and understand all public official WHO and goverment records on current situations and recommendations. Thus every user can jump into the app and ask Iaso whatever he wants to know about the current situation or how to behave.
The bots
The backend of the bot uses NLP on Azure to scan verified trusted sources (WHO, ECDC) to build and update a knowledge base on a daily basis that users can then query. It can then be accessed via an API endpoint or through various integrations (Amazon Alexa, Viber, WhatsApp)

# Cough detection system
Collecting the information on symptoms can be important for detecting if a person has a disease or not. As a first step, cough detection would be used to measure if and how much does a person cough during the day (e.g. using a phone or Alexa) and to notify the user if the pattern shows potential disease.

We build a cough detection system by training a deep learning classifier on different sounds, including cough, in order to discriminate if the sound is a cough or not. Since there is no out-of-the-box cough/no-cough dataset, we used Google Audioset and FreesoundDataset and reorganized the data in order to have a a big, joint, dataset with equal number of 'cough' and 'no cough' samples (1033 .wav files per class).

Our classifier is implemented in PyTorch and leverages torchaudio library for sound processing for neural networks. The classifier takes as input 1 second of audio converted to a visual representation - mel-spectrogram. We used a ResNet18 as our model, trained for 30 epochs, which achieves accuracy of 84% on validation set.

# Challenges we ran into
For the mobile app side, Flutter & Dart languages were a new beast to tame for some of us but it was the right decision since now the Iaso app can now be used by both Android, iOs and Web users. Also, coordination between features, verified data sets, AI and machine learning was a struggle worth enduring to get the dish with best spices to ward of the Covid dangers

For the bot side of the job, it was rather difficult to connect the Azure bot backend to Alexa Skills via an endpoint, and took a lot of effort and time to adapt it.

Accomplishments that we're proud of
We actually made something that we believe can be really useful, and we've connected a bunch of fields and technologies in doing so. We've all done all sorts of stuff for the first time during this, and we've managed to release the app in 72h. Also, as the bot side can be used as a reliable and trusted source of daily information, it brings a smile (or a smirk) to our faces, since it battles misinformation on at least some level.

We also had fun. :)

# What we learned
That epidemiology and virology and public health are immensely complicated topics that have so many dedicated people spending their lives preparing us for situations like this, whom we don't neccessarily appreciate enough. Hats off to all of them.

# What's next for Iaso
Fixing bugs, adding more integrations (Google Home), finishing features (72h is a lot of time, but not that much :)) and releasing the App hopefully. Some of us are unemployed, some are students, we'd love to work on it if it'd be useful to anyone. So try it out and let us know what you think, both good and bad. :)

## Built With
amazon-alexa
azure
dart
firebase
flutter
machine-learning
