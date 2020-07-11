from bs4 import BeautifulSoup 
import requests, random


res = requests.get('https://truesteamachievements.com/game/PAYDAY-2/achievements').text
soup = BeautifulSoup(res, 'lxml')

#TODO - modular o que está em baixo para conseguir ir buscar os achievments das duas paginas sem repetir codigo
#Vou ter de usar selenium e webdriver se quero conseguir mudar a pagina.

numerosRepetidos = []
achievmentsList = []
data_raw = soup.find_all('ul', attrs={'class': 'ach-panels'})
for group in data_raw:
    achievs = group.find_all('li')

    for achiev in achievs:
        title = achiev.find('a').text
        description = achiev.find('p').text
        achievmentsList.append(f'{title}: {description}')

resposta = ''
while(resposta != 'q'):
    x = random.randint(1, 1000)
    if x in numerosRepetidos:
        continue
    else:
        numerosRepetidos.append(x)
    print(achievmentsList[x])
    resposta = input('Carrega enter para gerar outro achievment ou "q" para sair.')

