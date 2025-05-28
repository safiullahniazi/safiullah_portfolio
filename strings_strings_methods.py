students = [
    ("Alice", 85, 92, 78),
    ("Bob", 75, 88, 90),
    ("Charlie", 92, 90, 85),
    ("Alice", 85, 92, 78)
]

# Function to calculate average score
def calculate_average(student):
    name, score1, score2, score3 = student
    average = (score1 + score2 + score3) / 3
    return average

excellent_students = [] ## Declared outside to prevent from cleaning list everytime loop executes
for student in set(students): # Only Unique Values in a list with set keyword
    average_score = calculate_average(student)
    print(f"{student[0]}'s average score is: {average_score:.2f}")
    if average_score >= 85.00:
        print("Excllent")
    else:
        print("Need Improvement")
    name = student[0]
    if round(average_score, 2) >= 85.00:
        excellent_students.append(name)
    unique_names = list(set(excellent_students))
print("Students with an average score of 85.00 or greater:", unique_names)


## formatiing in pyhton
version_message = "Version {version} or higher required"
print(version_message.format(version="3.10"))
print(version_message.strip())

name = "Safiullah"
print(f"Hello, {name}! Welcome to CS")
print(f"Hello, {name}! Welcome to CS {3.15}")

