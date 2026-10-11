SEG = {
    0: 0b0000001,
    1: 0b1001111,
    2: 0b0010010,
    3: 0b0000110,
    4: 0b1001100,
    5: 0b0100100,
    6: 0b0100000,
    7: 0b0001111,
    8: 0b0000000,
    9: 0b0000100,
}

def model(bcd):
    return SEG.get(bcd, 0b1111111)

def run():
    for x in range(16):
        y=model(x)
        if x <= 9:
            assert y == SEG[x]
        else:
            assert y == 0b1111111
    assert model(0)==0b0000001
    assert model(9)==0b0000100
    assert model(10)==0b1111111
    assert model(15)==0b1111111
    print("B01 independent Python model: PASS")

if __name__=="__main__":
    run()
