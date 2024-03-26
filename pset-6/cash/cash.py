from cs50 import get_float

while True:
    try:
        input = get_float("Change Owed: ")
        if input > 0:
            break
    except:
        print("", end="")

coins = 0

change = input * 100

while change >= 25:
    change = change - 25
    coins = coins + 1

while change >= 10:
    change = change - 10
    coins = coins + 1

while change >= 5:
    change = change - 5
    coins = coins + 1

while change >= 1:
    change = change - 1
    coins = coins + 1

print(coins)
