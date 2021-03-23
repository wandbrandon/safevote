
from Block import Block
from Blok_Chain import Block_Chain
from AES_Block import AES_Block
from AES_Block_Chain import AES_Block_Chain
import hashlib

# hash = hashlib.sha256("RAH YUT KILL".encode()).hexdigest()

# next_hash = hashlib.sha256(hash + "RAH YUT KILL".encode()).hexdigest()

# # print(hash)
# # print (next_hash)
# first_block = Block("AROD", "trump",  IV = "RAH YUT KILL"  )
# # print(first_block.block)


# block_chain = Block_Chain(first_block)

# curr = block_chain.Get_Curr_Block().block

# print(block_chain.Get_Curr_Block().block)

# next_block = Block("Brandito", "BIDen", block_chain.Get_Curr_Block().block)

# block_chain.Add_Block(next_block)

# print(block_chain.chain[1].block)

# third_block = Block("DANIEL", "TRUMP", block_chain.Get_Curr_Block().block)

# block_chain.Add_Block(third_block)

# print(block_chain.chain[2].block)

# print(type(block_chain[0]))

# test = block_chain.Block_To_Int(block_chain[0])

# test1 = block_chain.Block_To_Int(block_chain[1])

# result = test1 - test

# print(result)

# hex_val = hex(result)

# yut = hashlib.sha256(hex_val.decode())

# print(yut.hexdigest().decode("hex"))
# print(block_chain[0].decode("hex"))

aes_block = AES_Block("AROID", "TRUMP", IV = "RAHYUTKILLPOLIUH")
aes_block2 = AES_Block("Rod", "Biden", previous_block = aes_block)


aes_block_chain = AES_Block_Chain(aes_block)

aes_block_chain.Add_Block(aes_block2)

aes_block3 = AES_Block("Brandito", "Kanye", previous_block = aes_block_chain.Get_Curr_Block())

aes_block_chain.Add_Block(aes_block3)

yut = aes_block2.Decrypt_Block()

d = aes_block.Decrypt_Block()

rah = aes_block3.Decrypt_Block()


# print(d)

# print(yut)

# print(rah)

for i in range(10000):

    if ( i % 2 ):
        new_block = AES_Block("ROD", "TRUMP", aes_block_chain.Get_Curr_Block())
        aes_block_chain.Add_Block(new_block)
    else:
        new_block = AES_Block("Brandon", "Kanye" , aes_block_chain.Get_Curr_Block())
        aes_block_chain.Add_Block(new_block)


users, results = aes_block_chain.Calculte_Votes(["Kanye", "TRUMP", "Biden"])

print (users)
print (results)



