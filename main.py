from faker import Faker

fake = Faker()


def main():
    print(fake.text())


if __name__ == "__main__":
    main()