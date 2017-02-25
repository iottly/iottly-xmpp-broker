# License

Copyright 2015 Stefano Terna

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# iottly-xmpp-broker

The *iottly-xmpp-broker* repo hosts the Openfire configuration for the development environment.

The `xmppbroker` container is built starting from the configuration contained in the `dev_openfire_data` directory.
The configuration data is added statically to the container, so that, after altering it, if you want to restart from a clean configuration, you just remove the container and start a new one:
- `cd iottly-docker`
- `docker-compose stop xmppbroker`
- `docker-compose rm xmppbroker`
- `./start_iottly_locally.sh`

This behaviour changes if the `/var/lib/openfire` directory is mounted from a host volume: in this case it is persisted and the configuration is taken from `dev_openfire_data` only during the first fireup of the container.

# Preloaded plugins
The configuration comes with preloaded Openfire plugins:

|Plugin             | Description                                                                                                    | Version   | Author                     |
|-------------------|----------------------------------------------------------------------------------------------------------------|-----------|----------------------------|
|Client Control     | Controls clients allowed to connect and available features                                                     | 01.02.00  | Jive Software              |
|HTTP Forward       | Forwards message packets to an HTTP endpoint [iottly-httpforward(https://github.com/iottly/iottly-httpforward)]| 00.03.01  | Stefano Terna              |
|Presence Service   | Exposes presence information through HTTP.                                                                     | 01.06.00  | Jive Software              |
|Registration       | Performs various actions whenever a new user account is created.                                               | 01.06.00  | Ryan Graham                |
|User Creation      | Creates users and populates rosters.                                                                           | 01.02.00  | Jive Software              |
|User Import Export | Enables import and export of user data                                                                         | 02.04.00  | Ryan Graham                |
|User Service       | (Deprecated) Please use the REST API Plugin. Allows administration of users via HTTP requests.                 | 02.00.02  | Roman Soldatow Justin Hunt |


# Configuration
The following env variables are interpolated by the `entrypoint.sh` script into the database init script file (so that they can be overridden by the compose configuration):
- `HTTPFORWARD_TARGET` - The default url of the endpoint to post messages to (ref [iottly-httpforward](https://github.com/iottly/iottly-httpforward))
- `HTTPFORWARD_ALLOWEDRECIPIENTS` - A comma separated list of message recipients to forward (ref [iottly-httpforward](https://github.com/iottly/iottly-httpforward))
- `HTTPFORWARD_RECIPIENTROUTES` - A comma separated list of key values defining a map from recipients to target URLs to forward to (i.e. username,url,username,url,username,url) (ref [iottly-httpforward](https://github.com/iottly/iottly-httpforward))
- `XMPP_DOMAIN` - the domain of the broker (e.g. `JID = [some username]@${XMPP_DOMAIN})