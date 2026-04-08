def test_fizz_buzz():
    from example.fizzbuzz import fizz_buzz

    assert fizz_buzz(1) == "1"
    assert fizz_buzz(2) == "2"
    assert fizz_buzz(3) == "Fizz"
    assert fizz_buzz(4) == "4"
    assert fizz_buzz(5) == "Buzz"
    assert fizz_buzz(10) == "Buzz"
    assert fizz_buzz(15) == "FizzBuzz"
    assert fizz_buzz(75) == "FizzBuzz"
    assert fizz_buzz(83) == "83"
    assert fizz_buzz(99) == "Fizz"
    assert fizz_buzz(100) == "Buzz"
