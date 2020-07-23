import requests

url = "https://canarado-lyrics.p.rapidapi.com/lyrics/"
musicName = 'abba dancing queen'.split()
numberWords = len(musicName)

for word in musicName:
    url = url + word + '%2520'


headers = {
    'x-rapidapi-host': "canarado-lyrics.p.rapidapi.com",
    'x-rapidapi-key': "c67a843d17msh9a57e540bff02f7p183fb2jsn63e0c239b187"
    }

response = requests.request("GET", url, headers=headers)
response = response.json()['content']
#print(response)

correctWords = 0
for part in response:
    for word in musicName:
        if word.lower() in part['title'].lower():
            correctWords+=1
    if correctWords == numberWords:
        print(part['lyrics'])
        correctWords = 0
        break
    
