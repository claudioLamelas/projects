# Python program to translate 
# speech to text and text to speech 
  
import speech_recognition as sr 
import pyttsx3, sys
from covid import getDadosAudio
import weather
  
# Initialize the recognizer  
r = sr.Recognizer()  
r.energy_threshold = 1000
  
# Function to convert text to 
# speech 
def SpeakText(command): 
      
    # Initialize the engine 
    engine = pyttsx3.init() 
    engine.say(command)  
    engine.runAndWait() 
      

# Loop infinitely for user to 
# speak 
  
while True:     
      
    try: 
          
        # use the microphone as source for input. 
        with sr.Microphone(device_index=1) as source2: 
              
            # wait for a second to let the recognizer 
            # adjust the energy threshold based on 
            # the surrounding noise level  
            r.adjust_for_ambient_noise(source2, duration=0.7) 
            print('Podes falar')
              
            #listens for the user's input  
            audio2 = r.listen(source2) 
              
            # Using google to recognize audio 
            myText = r.recognize_google(audio2) 
            myText = myText.lower() 
            print('Disseste ' + myText + '?')
  
            keyWords = myText.split()
            if 'coronavirus' in keyWords and len(keyWords) >= 2:
                print('Retriving information about {}'.format(myText))
                getDadosAudio(keyWords[1])
            elif 'coronavirus' in keyWords and len(keyWords) < 2:
                print('Indicate the country please:')
                country = r.recognize_google(r.listen(source2))
                print('Retriving information about {}'.format(myText + ' ' + country))
                getDadosAudio(country)

            if ('weather' in keyWords):
                print('Que região?')
                regiao = r.recognize_google(r.listen(source2), language='pt-PT')
                print('Meteorologia para {}:'.format(regiao))
                weather.getDados(local = regiao)    #TODO - FAZER COM QUE DÊ PARA ESCOLHER O LOCAL POR VOZ
            
            
            if 'bye' in myText or 'stop' in myText:
                print('Goodbye gostosão')
                break
              
    except sr.RequestError as e: 
        print("Could not request results; {0}".format(e)) 
          
    except sr.UnknownValueError: 
        print("unknown error occured") 