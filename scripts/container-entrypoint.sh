#!/bin/bash

#set -euxo pipefail
set -eux

npx prisma migrate deploy
npm run start
