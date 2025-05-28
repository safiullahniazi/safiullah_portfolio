def prefix_sum(input_list):
    prefix_sums = []
    current_sum = 0
    print (input_list)
    for i in input_list:
        current_sum = current_sum + i
        prefix_sums.append(current_sum)
    return prefix_sums

print(prefix_sum([1, 2, 3, 4]))


## Python Functions(Built-in library functions & User defined Functions)


## *args, and **kwargs

def myfun(*argv):
    for arg in argv:
        print(arg)

myfun("Hello","my","name","is","Safiullah")

def myFun(**kwargs):
    for key, value in kwargs.items():
        print(key, value)
myFun(first='Safiullah',last='Khan',tribe='Niazi')


##Docstring(Used to describe the functionality of function

def evenOdd(x):
    """Function to check if the number is even or odd"""
    if x % 2 == 0:
        print("Even")
    else:
        print("Odd")
print(evenOdd.__doc__)



