from bs4 import BeautifulSoup 
from selenium import webdriver
from pathlib import Path
from selenium.webdriver.chrome.options import Options


URL_MUNDO = 'https://www.worldometers.info/coronavirus/'
URL_PAIS = 'https://www.worldometers.info/coronavirus/country/'

def imprimeDados(country, dados, novosCasos=None):
    print()
    print(country.title() + ':')

    if novosCasos is None:
        print(f'Casos - {dados[0].text.strip()}')
        print()
        print(f'Mortos - {dados[1].text.strip()}')
    elif len(novosCasos) < 2:
        print(f'Casos - {dados[0].text.strip()} (+{novosCasos[0]} em 24h)')
        print()
        print(f'Mortos - {dados[1].text.strip()} (+0 em 24h)')
    else:
        print(f'Casos - {dados[0].text.strip()} (+{novosCasos[0]} em 24h)')
        print()
        print(f'Mortos - {dados[1].text.strip()} (+{novosCasos[1]} em 24h)')

    print()
    print(f'Recuperados - {dados[2].text.strip()}')
    print()

def initializeDriver():
    option = Options()                                  #Cria uma instancia de Options para poder mexer nas definiçoes do browser
    option.add_argument('--headless')                   #Faz com que não apareça o browser ao ser aberto

    driver = webdriver.Chrome(Path('D:/Software/Ferramentas/chromedriver.exe'), options=option)
    return driver

def retrieveInformation(country, driver):
    if country.lower() == 'world' or country.lower() == 'mundo':
        driver.get(URL_MUNDO)
    else:
        driver.get(URL_PAIS + country.lower())

    res = driver.execute_script('return document.documentElement.outerHTML')          #tive de executar o javascript da pagina porque o conteudo da mesma                                                                     #é fornecido pelo javascript

    soup = BeautifulSoup(res, 'lxml')
    dados = soup.find_all('div', {'class' : 'maincounter-number'})

    if country.lower() != 'world' and country.lower() != 'mundo':
        #vai buscar os novos casos das ultimas 24h
        numsDiarios = soup.find('li', {'class' : 'news_li'}).text.split(' ')

        #extrai apenas os numeros - o split e o join sao usados para lidar com numeros na casa dos milhares, por terem virgula
        nums = [s for s in numsDiarios if (s.isdigit() or ('').join(s.split(',')).isdigit())]

        imprimeDados(country, dados, novosCasos=nums)
        return (dados, nums)
    else:
        imprimeDados(country, dados)
        return (dados)

def getDados():
    try:
        driver = initializeDriver()

        while True:
            country = input('Deseja obter informação de que país (Insira \'q\' para sair):')
            if country == 'q':
                break
            retrieveInformation(country, driver)
        
        driver.quit()
    except:
        print('O país que inseriu nao deve estar correto :(')

#função usada apenas no assistente pessoal
def getDadosAudio(country):
    try:
        driver = initializeDriver()
        dados = retrieveInformation(country, driver)
        driver.quit()

        return dados
    except:
        print('O país que inseriu nao deve estar correto :(')

#getDadosAudio('portugal')