import os
import sys

import psycopg
from dotenv import load_dotenv

load_dotenv()

url = os.getenv("DATABASE_URL")
if not url:
    sys.exit("DATABASE_URL não encontrada. Confira o arquivo .env na raiz do projeto.")

try:
    with psycopg.connect(url, connect_timeout=10) as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT version();")
            print("Conectado:", cur.fetchone()[0])

            cur.execute(
                """
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema = 'public'
                ORDER BY table_name;
                """
            )
            print("Tabelas:", [r[0] for r in cur.fetchall()])

            cur.execute("SELECT count(*) FROM causas WHERE status = 'ativa';")
            print("Causas ativas:", cur.fetchone()[0])
except Exception as e:
    sys.exit(f"Falha na conexão: {e}")