import psycopg2

db_conn = """        
        host='silly.db.elephantsql.com'
        dbname='subechgm'
        user='subechgm'
        password='8cU7M7G-ZMwse_4s1GMwZjvg-CnyAMsI'
        """


def execute(query):
    conn = psycopg2.connect(db_conn)

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()


def insert_account(account):

    query = f"""
        INSERT INTO accounts (name,email,cpf) 
        VALUES ('{account["name"]}', '{account["email"]}','{account["cpf"]}');
        """

    execute(query)



def delete_account_by_email(email):

    query = f"Delete from accounts where email = '{email}';"

    execute(query)

def insert_membership(data):

    account = data["account"]
    plan = data["plan"]
    card_last4_number = data["card_details"]["number"][-4]

    query = f"""
    BEGIN; -- Inicia uma transação

    -- Remove o registro pelo email
    DELETE FROM accounts
    WHERE email = '{account["email"]}';

    --Insere uma nova conta e obtém o ID da conta recém-inserida
    WITH new_account AS (
        INSERT INTO accounts (name, email, cpf)
        VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}')
        RETURNING id
    )

    --Insere um registro na tabela memberships com o ID da conta
    INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
    SELECT id, {plan["id"]}, '{card_last4_number}', {plan["price"]}, true
    FROM new_account;

    COMMIT; --Confirma a transacão
    """

    execute(query)