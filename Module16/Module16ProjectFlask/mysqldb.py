import pymysql

#import mysql.connector
#def insertMBTARecord(mbtaList):
#    mydb = mysql.connector.connect(
#    host="localhost",
#    user="root",
#    password="MyNewPass",
#    database="MBTAdb"
#    )

def insertMBTARecord(mbtaList):
    mydb = pymysql.connect(user='root', password='MyNewPass', host='127.0.0.1', db='MBTAdb')
    mycursor = mydb.cursor()
    #complete the following line to add all the fields from the table
    sql = "insert into mbta_buses (id, latitude, longitude, vtype, direction_id, occupancy_status, current_status, current_stop_sequence, speed, updated_at, rtid) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    for mbtaDict in mbtaList:
        #complete the following line to add all the fields from the table
        val = (mbtaDict['id'], mbtaDict['latitude'], mbtaDict['longitude'], mbtaDict['vtype'], mbtaDict['direction_id'], 
               mbtaDict['occupancy_status'], mbtaDict['current_status'], mbtaDict['current_stop_sequence'],
               mbtaDict['speed'], mbtaDict['updated_at'], mbtaDict['rtid'])
        mycursor.execute(sql, val)
        mydb.commit()

#cnx.commit()