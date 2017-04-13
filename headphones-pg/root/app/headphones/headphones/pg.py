
###################################
# Adapted from db.py  #
###################################

from __future__ import with_statement

import psycopg2

#import os
import headphones
from headphones import logger


#def dbFilename(filename="headphones.db"):
#    return os.path.join(headphones.DATA_DIR, filename)

# Set up connection details from config.ini file
# TODO - use env
def dbHost():
    logger.info("Returning dbHost as " + headphones.CONFIG.DB_HOST)
    return headphones.CONFIG.DB_HOST

def dbName():
    logger.info("Returning dbName as " + headphones.CONFIG.DB_NAME)
    return headphones.CONFIG.DB_NAME

def dbUser():
    return headphones.CONFIG.DB_USER

def dbPass():
    return headphones.CONFIG.DB_PASS


# def getCacheSize():
#     # this will protect against typecasting problems produced by empty string and None settings
#     if not headphones.CONFIG.CACHE_SIZEMB:
#         # sqlite will work with this (very slowly)
#         return 0
#     return int(headphones.CONFIG.CACHE_SIZEMB)


class DBConnection:
    def __init__(self):

        #self.connection = sqlite3.connect(dbFilename(filename), timeout=20)
        logger.info("Connecting with string: host=" + dbHost() + " dbname=" + dbName() + " user=" + dbUser() + " password=" + dbPass())
        self.connection = psycopg2.connect("host=" + dbHost() + " dbname=" + dbName() + " user=" + dbUser() + " password=" + dbPass())

        # don't wait for the disk to finish writing
        #self.connection.execute("PRAGMA synchronous = OFF")
        # journal disabled since we never do rollbacks
        #self.connection.execute("PRAGMA journal_mode = %s" % headphones.CONFIG.JOURNAL_MODE)
        # 64mb of cache memory,probably need to make it user configurable
        #self.connection.execute("PRAGMA cache_size=-%s" % (getCacheSize() * 1024))
        #self.connection.row_factory = sqlite3.Row

    def action(self, query, args=None):

        if query is None:
            return

        sqlResult = None

        logger.info("Query is " + query)

        try:
            with self.connection.cursor() as c:
                if args is None:
                    logger.debug("action Args are None")
                    sqlResult = c.execute(query)
                else:
                    logger.debug("action Args are " + args)
                    sqlResult = c.execute(query, args)

        except psycopg2.OperationalError, e:
            logger.error('Database error: %s', e)
            raise

        except psycopg2.DatabaseError, e:
            logger.error('Fatal Error executing %s :: %s', query, e)
            raise

        #return sqlResult
        return self.c

    def select(self, query, args=None):

        logger.info("select Query is " + query)

        #sqlResults = self.action(query, args).fetchall()
        try:
            with self.connection.cursor() as c:
                if args is None:
                    logger.debug("select Args are None")
                    c.execute(query)
                    sqlResults = c.fetchall()
                else:
                    logger.debug("select Args are " + args)
                    c.execute(query, args)
                    sqlResults = c.fetchall()

        except psycopg2.OperationalError, e:
            logger.error('Database error: %s', e)
            raise

        except psycopg2.DatabaseError, e:
            logger.error('Fatal Error executing %s :: %s', query, e)
            raise

        if sqlResults is None or sqlResults == [None]:
            return []

        return sqlResults

    def upsert(self, tableName, valueDict, keyDict):

        def genParams(myDict):
            return [x + " = ?" for x in myDict.keys()]

        #changesBefore = self.connection.total_changes

        update_query = "UPDATE " + tableName + " SET " + ", ".join(
            genParams(valueDict)) + " WHERE " + " AND ".join(genParams(keyDict))

        #self.action(update_query, valueDict.values() + keyDict.values())
        try:
            with self.connection.cursor() as c:
                logger.debug("update Args are " + valueDict.values() + keyDict.values())
                c.execute(update_query, valueDict.values() + keyDict.values())

                if ( c.rowcount == 0 ) :

                    insert_query = (
                        "INSERT INTO " + tableName + " (" + ", ".join(
                            valueDict.keys() + keyDict.keys()) + ")" +
                        " VALUES (" + ", ".join(["?"] * len(valueDict.keys() + keyDict.keys())) + ")"
                    )
                    try:
                        #self.action(insert_query, valueDict.values() + keyDict.values())
                        with self.connection.cursor() as c:
                            logger.debug("insert Args are " + valueDict.values() + keyDict.values())
                            c.execute(insert_query, valueDict.values() + keyDict.values())
                            #rowcount = c.rowcount
                    except psycopg2.IntegrityError:
                        logger.info('Queries failed: %s and %s', update_query, insert_query)
        except psycopg2.IntegrityError:
            logger.info('Queries failed: %s and %s', update_query, insert_query)
