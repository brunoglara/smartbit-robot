from faker import Faker

fake = Faker('pt_BR')

def get_fake_account():
    account = {
        "name": fake.name(),
        "email": fake.email(),
        "cpf": fake.cpf(),
        "incorrect_email": fake.email().replace('@', '#'),
        "incorrect_cpf": fake.cpf()[:-2] + '99'
    }
    return account