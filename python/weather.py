import requests, pprint
from datetime import datetime

HOURS_ALLOWED = ['09:00:00', '12:00:00', '15:00:00', '18:00:00', '21:00:00']

def reorderDate(date):
    return datetime.strptime(date, '%Y-%m-%d').strftime('%d-%m-%Y')

def imprimirDados(dias, horas, tempNow, tempFeelsLike, descriptions):
    i = 0
    for dia in dias:
        print()
        print(datetime.strptime(dia, '%d-%m-%Y').strftime('%d %B'))
        print()
        if datetime.now().strftime('%d-%m-%Y') == dia:
            for k in range(len(HOURS_ALLOWED) - HOURS_ALLOWED.index(horas[0])):
                print(f' {horas[k][:2]} h    Temp - {round(float(tempNow[k]))}ºC    Feels Like - {round(float(tempFeelsLike[k]))}ºC    {descriptions[k]}')
                i+=1
        else:
            try:
                for k in range(len(HOURS_ALLOWED)):
                    print(f' {horas[i][:2]} h    Temp - {round(float(tempNow[i]))}ºC    Feels Like - {round(float(tempFeelsLike[i]))}ºC    {descriptions[i]}')
                    i+=1
            except IndexError:
                continue
               
def getDados(local = None):
    try:
        if local is None:
            local = input('Quer ver a meteorologia de que Cidade/Concelho/Freguesia: ')
    
        url = 'https://api.openweathermap.org/data/2.5/forecast?q={},PT&appid=9ef6f5ea5bba1672c2353269f5243714&units=metric'.format(local)
        data = requests.get(url).json()

        dias, horas, tempNow, tempFeelsLike, descriptions = ([] for i in range(5))

        for d in data['list']:
            dia = d['dt_txt'].split()[0]
            hora = d['dt_txt'].split()[1]

            if reorderDate(dia) not in dias:
                dias.append(reorderDate(dia))

            if hora in HOURS_ALLOWED:
                horas.append(hora)

            tempNow.append(d['main']['temp'])
            tempFeelsLike.append(d['main']['feels_like'])
            descriptions.append(d['weather'][0]['description'])

        imprimirDados(dias, horas, tempNow, tempFeelsLike, descriptions)
    except:
        print('Sem informação para a {}'.format(local))
    

getDados()
input()
    
