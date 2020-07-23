import requests


while True:
    url = "https://canarado-lyrics.p.rapidapi.com/lyrics/"
    musicName = input('Queres ver as lyrics de que musica? (Indica nome e artista)\n"q" para parar ')

    if (musicName == 'q'):
        break

    musicNameSplit = musicName.split()
    numberWords = len(musicNameSplit)

    for word in musicNameSplit:
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
        #print(part['title'])
        for word in musicNameSplit:
            if word.lower() in part['title'].lower():
                correctWords+=1
        if correctWords == numberWords:
            print(part['title'])
            print()
            print(part['lyrics'])
            print()
            correctWords = 0
            break

