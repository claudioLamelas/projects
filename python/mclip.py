#! python3
# mclip.py - Dependendo da palavra chave dada, é copiada uma mensagem para o clipboard

TEXT = {'agree': """Yes, I agree. That sounds fine to me.""",
        'busy': """Sorry, can we do this later this week or next week?""",
        'upsell': """Would you consider making this a monthly donation?"""}

import sys, pyperclip

if len(sys.argv) < 2:
    print('Usage: python mclip.py [keyphrase] - copy phrase text')
    sys.exit()

keyphrase = sys.argv[1]    # first command line arg is the keyphrase

if keyphrase in TEXT:
    pyperclip.copy(TEXT[keyphrase])
    print('O texto para {} foi copiado.'.format(keyphrase))
else:
    print('Não tens um texto para {} predefenido, deseja adicionar um? (y)es ou (n)o.'.format(keyphrase))
    response = input()
    if response == 'y':
       newMessage = input('Que mensagem quer adicionar para {}?'.format(keyphrase))
       TEXT[keyphrase] = newMessage
       print(TEXT)
    
    else:
        sys.exit()