import pytube as pt
import requests
from bs4 import BeautifulSoup

desktopPath = r'D:\Videos'
keyCategorys = {
    'ASMR': ['asmr', 'whisper', 'roleplay'],
    'Tutorial': ['tutorial', 'learning', 'basics', 'guide', 'beginners', 'programming'],
    'Gaming': ['gameplay', 'walkthrough', 'gaming', 'games', 'valorant', 'fifa', 'dauntless'],
    'DIY': ['diy', 'craft', 'handmade', 'reciclável', 'original', 'creative']
}

def dictCheck(keys, word):
    for key in keys:
        for p in keyCategorys[key]:
            if p in word.lower():
                return key
    return ''           

def checkCategory(title, keywords):
    titleWords = title.split(' ')
    keys = keyCategorys.keys()

    for word in titleWords:
        indice = dictCheck(keys, word)
        if indice != '':
            return indice

    for keyword in keywords:
        indice2 = dictCheck(keys, keyword)
        if indice2 != '': 
            return indice2
    
    return 'Random'

def downloadVideos(urllist):
    for url in urllist:
        video = pt.YouTube(url)
        keywords = video.keywords
        title = video.title
        destinationFolder = checkCategory(title, keywords)

        print(keywords)
        print(title)
        print(destinationFolder)

        stream = video.streams.get_by_itag(22)
        if stream is None:
            stream = video.streams.get_highest_resolution()

        print('Downloading...')
        stream.download(desktopPath + '\\' + destinationFolder)
        print('Done')


urllist = []
stop = 0

choice = input('Videos (v) or Playlist (p): ')

if choice == 'v':
    while True:
        while True:
            url = input("Insert an URL or (d) to download or (s) to exit: ")
            if url == 'd': break
            if url == 's': 
                stop = 1
                break
            urllist.append(url)
        
        if stop == 1:
            break
        
        downloadVideos(urllist)

elif choice == 'p':
    #url = input("Insert an URL or (s) to exit: ")
    url = 'https://www.youtube.com/playlist?list=PL7yh-TELLS1G9mmnBN3ZSY8hYgJ5kBOg-'
    if url == 's': 
        exit()
    #playlist = pt.Playlist(url)
    #playlist._video_regex = re.compile(r"\"url\":\"(/watch\?v=[\w-]*)")

    #--------------------PLAYLISTS NAO FUNCIONAM POR ISSO POSSO TENTAR FAZER COM WEBSCRAPING--------------
    #COM O LINK DA PLAYLIST IR BUSCAR O HTML, DEPOIS NAVEGAR PELO HTML E IR BUSCAR OS LINKS DE CADA VIDEO NA PLAYLIST
    
    response = requests.get(url).text
    soup = BeautifulSoup(response, features='lxml')
    videos = soup.find('div', attrs={'class': 'style-scope ytd-playlist-video-list-renderer'})
    print(videos)
    #print(soup.prettify())
    #Wprint(response)
    
    