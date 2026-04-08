def main():
    for i in range(1, 101):
        print(fizz_buzz(i))


def fizz_buzz(num: int) -> str:
    if num % 3 == 0 and num % 5 == 0:
        return "FizzBuzz"
    elif num % 3 == 0:
        return "Fizz"
    elif num % 5 == 0:
        return "Buzz"
    else:
        return str(num)


if __name__ == "__main__":
    main()
