# MineplexInDocker

If someone were to, with the EXPRESS permission of Mineplex LLC, receive access to the source code of the original Mineplex from approximately 2018, they could, with the express permission of Mineplex LLC, _theoretically_ use this repository to run it in Docker in one click.

> [!WARNING]  
> This repository is for research and education purposes. It does NOT contain any Mineplex source code, which that belongs to Mineplex LLC. Do NOT violate Mineplex LLC copyright.

If you do, don't tell me about it. Thanks.

### Setup Instructions

Everything you need *except* for the **Arcade.jar** and **maps** are provided, which I CANNOT distribute as that would be copyright infringement. You should get those directly from Mineplex LLC with their permission.  I do not condone copyright infringement.

All other files you need are in the [./example](example) directory, as well as [./MinecraftServer](MinecraftServer), and [./WebServer](WebServer).

1. Procure a compiled `Arcade.jar` from around the year 2018 with the following modifications:
   1. `Redis URI: 127.0.0.1:6379`
   2. `MySQL URI: 127.0.0.1:3306`
   3. `WebServer URI: 127.0.0.1:1000`
2. Build the docker image for `WebServer` and `MinecraftServer`. 
   1. `WebServer` is reverse-engineered and NOT property of Mineplex
   2. `MinecraftServer` is just a wrapper for craftbukkit and NOT property of Mineplex
3. Run `docker-compose.yml` as-is. Upon first load, it will:
   1. Pre-populate the databases with the required tables
   2. Pre-populate the redis with the required configuration
   3. Generate the lobby world
4. Attach to the container via `docker attach mineplex-server` and turn off the whitelist `whitelist off`
5. To edit ranks, expose your MariaDB port and edit freely in the `accountranks` table.
6. One of the generated folders will be `maps`. In this folder, place the maps you have LEGALLY OBTAINED. The format is `maps/Bacon Brawl/Bacon_Lava.zip` (repeat for other game types)
7. Restart the server with your maps and you should be good to go.