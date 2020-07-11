import pyautogui, subprocess, time, covid
from bs4 import BeautifulSoup 


totais, novos = covid.getDadosAudio('portugal')

if len(novos) < 2:
    frase = f'Casos - {totais[0].text.strip()} (+{novos[0]} em 24h)\n\nMortos - {totais[1].text.strip()} (+0 em 24h)\n\nRecuperados - {totais[2].text.strip()}'
else:
    frase = f'''Casos - {totais[0].text.strip()} (Mais {novos[0]} em 24h)
                Mortos - {totais[1].text.strip()} (Mais {novos[1]} em 24h)
                Recuperados - {totais[2].text.strip()}'''

time.sleep(3)

wpp = subprocess.Popen('C:\\Users\\claud\\AppData\\Local\\WhatsApp\\WhatsApp.exe')

time.sleep(10)

w = pyautogui.getActiveWindow()
w.maximize()

pyautogui.click(294,224)   # Clica na conversa da patricia
pyautogui.click(835, 1002)
pyautogui.write(frase)
pyautogui.click(1880, 997)

w.close()