from sqlalchemy import create_engine, Column, Integer, String, Date, ForeignKey, UniqueConstraint
from sqlalchemy.orm import sessionmaker,declarative_base
import pymysql

Base = declarative_base()

class Customers(Base):
    __tablename__ = 'customers'
    customer_id = Column(Integer,primary_key=True)
    name = Column(String(255),nullable=False)
    email = Column(String(255),nullable=False, unique=True)


class Products(Base):
    __tablename__ = 'products'
    product_id = Column(Integer,primary_key=True)
    name = Column(String(255),nullable=False)
    price = Column(Integer,nullable=False)

class Orders(Base):
    __tablename__ = 'orders'
    order_id = Column(Integer,primary_key=True)
    customer_id = Column(Integer,ForeignKey('customers.customer_id'))
    order_date = Column(Date,nullable=False)

class OrderItems(Base):
    __tablename__ = 'orderitems'
    item_id = Column(Integer,primary_key=True)
    order_id = Column(Integer,ForeignKey('orders.order_id'))
    product_id = Column(Integer,ForeignKey('products.product_id'))
    quantity = Column(Integer,nullable=False)

class Payments(Base):
    __tablename__ = 'payments'
    payment_id = Column(Integer,primary_key=True)
    amount = Column(Integer,nullable=False)
    payment_date = Column(Date,nullable=False)
    order_id = Column(Integer,ForeignKey('orders.order_id'))

sqlite_engine = create_engine('sqlite:///order.db')
mysql_engine = create_engine(
    'mysql+pymysql://root:%24Freeman_007%24@localhost:3306/librarydb'
)


SQLite_Session = sessionmaker(bind=sqlite_engine)
sqlite_session = SQLite_Session()

MySQL_Session = sessionmaker(bind=mysql_engine)
mysql_session = MySQL_Session()

Base.metadata.create_all(mysql_engine)

for table in [Customers, Products, Orders, OrderItems, Payments]:
    records = sqlite_session.query(table).all()
    for record in records:
        mysql_session.merge(record)

mysql_session.commit()
sqlite_session.close()
mysql_session.close()