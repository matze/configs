import keyring
import getpass

if __name__ == '__main__':
    secret = getpass.getpass('GMail Password: ')
    keyring.set_password('gmail', 'matthias.vogelgesang@gmail.com', secret)
