#!/bin/sh

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CREDENTIALS=$1
if [ -n "$CREDENTIALS" ]; then
    export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS
fi

# Verify that we have authorized credentials by enumerating the GCP
# organizations. Enumerating the organizations will succeed if gcloud was
# able to obtain credentials, even if the active account cannot view any
# organizations.
gcloud organizations list 2>/dev/null 1>/dev/null
IS_AUTHORIZED=$?

if [ $IS_AUTHORIZED -eq 0 ]; then
    echo "gcloud authorized" 1>&2
else
    echo "gcloud not authorized" 1>&2
fi
exit $IS_AUTHORIZED
