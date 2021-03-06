# 
# Copyright 2015 Stefano Terna
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

FROM sameersbn/openfire:latest
MAINTAINER iottly

RUN apt-get update -y
RUN apt-get install -y gettext-base

ENV OPENFIRE_FIREUP_DIR=/var/lib/openfirefireup                                          \
	XMPP_DOMAIN=xmppbroker.localdev.iottly.org                                           \
	XMPP_USERNAME=iottlycore                                                             \
	XMPP_PASSWORD_ENC=0a7581473c8979a9798b339b77817129e6b29fdb87cecd240e16e1ae666d7464   \
	XMPP_MGMT_REST_SECRET=EKdj6y0USG4tP4Ki												 \
    HTTPFORWARD_ALLOWEDRECIPIENTS=                                                       \
    HTTPFORWARD_RECIPIENTROUTES=                                                         \
    HTTPFORWARD_TARGET=http://iottlycore:8520/msg


COPY docker-entrypoint.sh /sbin/entrypoint.sh

ADD /dev_openfire_data ${OPENFIRE_FIREUP_DIR}
