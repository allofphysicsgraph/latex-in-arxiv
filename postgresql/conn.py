from sqlalchemy import create_engine
from psycopg2 import connect
engine = create_engine('postgresql://arxiv:795e3522169@localhost/latex_in_arxiv')
conn = connect(dbname='latex_in_arxiv',user='arxiv',host='localhost',password='795e3522169',port=5433)
