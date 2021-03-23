import hashlib
import sys 
import select
from base64 import b64decode, b64decode
from Crypto.Hash import HMAC, SHA256
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from Crypto.Random import get_random_bytes

sha256 = SHA256.new()

class Block:
  #  IV = get_random_bytes(16)
    

    def __init__(self, user_id, vote, previous_block = None, IV = None):

        self.vote = vote
        self.user_id = user_id
        self.previous_block = previous_block
        
        if IV: # This is the initialization vector for first block
            self.IV = IV
            string_to_hash = ""+ user_id + vote + IV

        else:
            string_to_hash = ""+ previous_block + user_id + vote
            self.block = hashlib.sha256(string_to_hash.encode()).hexdigest()

        self.block = hashlib.sha256(string_to_hash.encode()).hexdigest()

    def Encrypt_Vote (self, vote):
        encrypted_vote = (vote.encode())
        return encrypted_vote

    def Decrypt_Vote (self, key, vote, compare):

        decryptHMAC = HMAC.new(key.encode(), vote.encode(), SHA256)

        decryptHMAC.update(vote)
        encrypt = decryptHMAC.hexdigest

        if(encrypt != compare):
            return False
        else:
            return True

    # def Encrypt_Block (self, key, data):
    #     #IV = get_random_bytes(16)
    #     cipher = AES.new(key, AES.MODE_CBC, self.IV)
    #     padded_data = pad(data,AES.block_size)
    #     encrypt_vote = cipher.encrypt(padded_data)
    #     print(sys.getsizeof(encrypt_vote))
    #     return encrypt_vote #, IV

    # def Decrypt_Block (self, key, block): # IV):
    #     cipher = AES.new(key, AES.MODE_CBC, self.IV)
    #     print (sys.getsizeof(block))
    #     decrypted_vote = cipher.decrypt(unpad(block, AES.block_size)) 
    #     print(decrypted_vote)
    #     return decrypted_vote


