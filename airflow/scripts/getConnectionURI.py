from airflow.models.connection import Connection
c = Connection(
    conn_id="some_conn",
    conn_type="mysql",
    description="connection description",
    host="myhost.com",
    login="myname",
    password="mypassword",
    extra={"this_param": "some val", "that_param": "other val*"},
)
print(f"AIRFLOW_CONN_{c.conn_id.upper()}='{c.as_json()}'")
AIRFLOW_CONN_SOME_CONN='{"conn_type": "mysql", "description": "connection description", "host": "myhost.com", "login": "myname", "password": "mypassword", "extra": {"this_param": "some val", "that_param": "other val*"}}'