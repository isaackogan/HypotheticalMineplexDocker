#!/bin/bash

# Static args
ARCADE_JAR_FP="./server/mineplex/plugins/Arcade.jar"
CRAFTBUKKIT_JAR_FP="/home/mineplex/server/mineplex/craftbukkit/craftbukkit.jar"
MAPS_DIR="./update/maps"
SERVER_WORKING_DIR="/home/mineplex/server/mineplex/"

MARIADB_MARKER_FILE="/home/mineplex/markers/initialized.mariadb.marker"
REDIS_MARKER_FILE="/home/mineplex/markers/initialized.redis.marker"

# SQL dir
SQL_DIR="./server/sql"
REDIS_FILE="./server/redis/config.redis"
CONFIG_TEMPLATE_FILE="./server/mineplex/plugins/Arcade/config.template.yml"
CONFIG_FILE="./server/mineplex/plugins/Arcade/config.yml"

WORLD_TEMPLATE="/home/mineplex/server/mineplex/world.template"
WORLD_FOLDER="/home/mineplex/server/mineplex/world"

echo "Initializing Mineplex in Docker..."

if [ -z "${MARIADB_HOST}" ] || [ -z "${MARIADB_PORT}" ] || [ -z "${MARIADB_USER}" ] || [ -z "${MARIADB_PASSWORD}" ]; then
  echo "Error: One or more required environment variables are not set or are empty." >&2
  echo "Required variables: MARIADB_HOST, MARIADB_PORT, MARIADB_USER, MARIADB_PASSWORD" >&2
  exit 1
fi

DB_HOSTNAME_PORT="$MARIADB_HOST:$MARIADB_PORT"

# MariaDB initialization
if [ ! -f "$MARIADB_MARKER_FILE" ]; then

  echo "Initializing MariaDB (USER=$MARIADB_USER, PASSWORD=$MARIADB_PASSWORD, HOST=$MARIADB_HOST, PORT=$MARIADB_PORT)..."
  echo "Creating Database Tables..."

  for SQL_FILE in "$SQL_DIR"/*.sql; do
    echo "Executing SQL File $SQL_FILE"
    mysql -h "$MARIADB_HOST" -P "$MARIADB_PORT" -u "$MARIADB_USER" -p"$MARIADB_PASSWORD" --force < "$SQL_FILE"
    echo Executing \"mysql -h "$MARIADB_HOST" -P "$MARIADB_PORT" -u "$MARIADB_USER" -p"$MARIADB_PASSWORD"\"

     if [ $? -eq 0 ]; then
        echo "Successfully executed: $SQL_FILE"
      else
        echo "Error executing: $SQL_FILE" >&2
      fi
  done

  touch $MARIADB_MARKER_FILE
  echo "MariaDB initialization completed. Marker file created: $MARIADB_MARKER_FILE"
else
  echo "MariaDB has already been initialized... skipping!"
fi


# Redis Initialization
if [ ! -f "$REDIS_MARKER_FILE" ]; then

  if [ -z "${REDIS_URI}" ]; then
    echo "Error: REDIS_URI is not set or is empty." >&2
    exit 1
  fi
  echo "Initializing Redis (URI=${REDIS_URI})..."

  echo "Creating Initial Redis Config..."
  echo "Executing Redis File $REDIS_FILE"

  redis-cli -u "$REDIS_URI" < "$REDIS_FILE"

  if [ $? -eq 0 ]; then
      echo "Successfully executed: $REDIS_URI"
  else
      echo "Error executing: $REDIS_URI" >&2
  fi

  touch $REDIS_MARKER_FILE
  echo "Redis initialization completed. Marker file created: $REDIS_MARKER_FILE"
else
  echo "Redis has already been initialized... skipping!"
fi


# Check for the Arcade.jar
if [ ! -f "$ARCADE_JAR_FP" ]; then
    echo "Error> File $ARCADE_JAR_FP does not exist! You must add an Arcade.jar. I cannot provide this for legal reasons."
    exit 1
fi

# Check for craftbukkit.jar
if [ ! -f "$CRAFTBUKKIT_JAR_FP"]; then
  echo "Error> File $CRAFTBUKKIT_JAR_FP does not exist! You must add a craftbukkit.jar. I cannot provide this for legal reasons."
  exit 1
fi

# Check for the maps
if ! find "$MAPS_DIR" -mindepth 1 -type d | grep -q .; then
  echo "Error> No maps found in '$MAPS_DIR'."
  exit 1
fi

# Delete the old world & replace it
echo "Overwriting world folder forcefully"
cp -rp $WORLD_TEMPLATE $WORLD_FOLDER

# Start the server
cd "$SERVER_WORKING_DIR"
chmod +x "$CRAFTBUKKIT_JAR_FP"
java -Xms"$MINIMUM_MEMORY" -Xmx"$MAXIMUM_MEMORY" -jar "$CRAFTBUKKIT_JAR_FP" nogui