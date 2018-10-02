import pyodbc

conexion = pyodbc.connect('Driver=FreeTDS;Server=SQLSERVER\SQLSERVER;Database=yggdrasil;uid=sa;pwd=s1cs3mp3rt1r4n1s')
cursor = conexion.cursor()
busqueda = cursor.execute('SELECT * FROM dbo.componentes')
busqueda.fetchall()
conexion.commit()
conexion.close()
