from Block import Block


class Block_Chain:

    def __init__(self, initial_block):
        self.vote_count = 1
        self.initial_block = initial_block
        self.chain = []
        self.chain.append(initial_block)

    def __getitem__ (self, index):
        return self.chain[index].block

    def Add_Block (self, block):
        self.vote_count += 1
        self.chain.append(block)

    def Block_To_Int(self, block):
        hex_string = int(block, 16)
        return hex_string

    def Get_Curr_Block (self):
        return self.chain[len(self.chain)-1]

    def Get_Init_IV (self):
        return self.chain[0].IV
    
    def Decode_BlockChain(self, block):

        for block in self.chain:
            if block.IV is not None:
                self.initial_block = block

    def Count_Votes(self, candidate_list):
        candidate_map = map ()

        return 0
    

    

     